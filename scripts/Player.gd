extends CharacterBody3D

class_name Player 

const SHAKE_FREQUENCY = 1.5
const SHAKE_AMPLITUDE = 0.06
var SFOV = 0.0
var speed 
const WALK_SPEED = 10.0
const SPRINT_SPEED = 20.0
const JUMP_VELOCITY = 10.0
const SENSITIVITY = 0.003
var gravity = 20
const FOV = 90.0
const FOV_MULTI = 1.25

var bullet = load("res://scenes/bullet.tscn")
var instance

@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D
@onready var stamina : ProgressBar = $"../Health_Stamina/Stamina Bar"
@onready var gun_animation = $Pivot/Camera3D/Pistol/AnimationPlayer
@onready var gun_barrel = $Pivot/Camera3D/Pistol/RayCast3D

var knockbackvelocity = Vector3.ZERO
var knockbacktime = 0.0
@export var knockbackforce = 30
@export var knockbackdur = 0.2



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	speed = WALK_SPEED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _physics_process(delta: float) -> void:
	if knockbacktime > 0:
		velocity = knockbackvelocity
		knockbacktime -= delta
	else:
		if not is_on_floor():
			velocity.y -= gravity * delta  


	if Input.is_action_pressed("sprint"):
		if stamina.value > 0:
			speed = SPRINT_SPEED
		else:
			speed = WALK_SPEED
	else:
		speed = WALK_SPEED


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0) 
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)


	SFOV += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(SFOV)
	
	if Input.is_action_pressed("shoot"):
		if !gun_animation.is_playing():
			gun_animation.play("shoot")
			instance = bullet.instantiate()
			instance.position = gun_barrel.global_position
			instance.transform.basis = gun_barrel.global_transform.basis
			get_parent().add_child(instance)
	
	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * SHAKE_FREQUENCY)* SHAKE_AMPLITUDE
	pos.x = cos(time * SHAKE_FREQUENCY/2) * SHAKE_AMPLITUDE
	return pos


func apply_knockback(from_position: Vector3) -> void:
	var dir = (global_position - from_position).normalized()
	knockbackvelocity = dir * knockbackforce
	knockbackvelocity.y = 5
	knockbacktime = knockbackdur
