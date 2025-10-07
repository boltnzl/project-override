extends CharacterBody3D

class_name Player 

const shake_frequency = 1.5
const shake_amplitude = 0.06
var sfov = 0.0
var speed 
const walk_speed = 10.0
const sprint_speed = 20.0
const jump_velocity = 10.0
const sensitivity = 0.003
var gravity = 20
const fov = 90.0
const fov_multi = 1.25

var bullet = load("res://scenes/bullet.tscn")
var instance
@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D
@onready var stamina : ProgressBar = $"Health_Stamina/Stamina Bar"
@export var max_health: float = 100
var current_health: float
@onready var health_bar = $"Health_Stamina/Health Bar"
@onready var gun_animation = $Pivot/Camera3D/Pistol/AnimationPlayer
@onready var gun_barrel = $Pivot/Camera3D/Pistol/RayCast3D
@export var max_mag = 25
@export var total_ammo = 100  
var current_mag = max_mag     
@onready var magazine_label = $AmmoCounter/Magazine
@onready var ammo_label = $AmmoCounter/Ammo
var reload_time = 2.0
var is_reloading = false 

var incombat = false
var timelasthit = 0.0
@export var regendelay = 3.0      
@export var regenrate = 10.0 

var knockbackvelocity = Vector3.ZERO
var knockbacktime = 0.0
@export var knockbackforce = 30
@export var knockbackdur = 0.2


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	speed = walk_speed
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
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
			speed = sprint_speed
		else:
			speed = walk_speed
	else:
		speed = walk_speed


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_pressed("reload"):
		_reload()
	
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
	sfov += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(sfov)
	
	if Input.is_action_pressed("shoot"):
		_shoot()
	  
	
	if not incombat:
		timelasthit += delta
		if timelasthit >= regendelay and current_health < max_health:
			current_health = min(current_health + regenrate * delta, max_health)
			_update_health_bar()
	else:
		timelasthit += delta
		if timelasthit >= regendelay:
			incombat = false


	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * shake_frequency)* shake_amplitude
	pos.x = cos(time * shake_frequency/2) * shake_amplitude
	return pos


func apply_knockback(from_position: Vector3) -> void:
	var dir = (global_position - from_position).normalized()
	knockbackvelocity = dir * knockbackforce
	knockbackvelocity.y = 5
	knockbacktime = knockbackdur


func _reload():
	if is_reloading:
		return
	if current_mag == max_mag:
		return
	if total_ammo <= 0:
		return 
	is_reloading = true
	await get_tree().create_timer(reload_time).timeout
	var ammo_needed = max_mag - current_mag
	if total_ammo > 0 and ammo_needed > 0:
		var to_load = min(ammo_needed, total_ammo)
		current_mag += to_load
		total_ammo -= to_load
		_update_ammo_ui()
		is_reloading = false


func _update_ammo_ui():
	magazine_label.text = str(total_ammo)
	ammo_label.text = str(current_mag)


func _shoot():
	if is_reloading:
		return
	if current_mag <= 0:
		return
	if current_mag <= 0 and total_ammo <= 0:
		return
	if !gun_animation.is_playing():
		gun_animation.play("shoot")
		instance = bullet.instantiate()
		instance.position = gun_barrel.global_position
		instance.transform.basis = gun_barrel.global_transform.basis
		get_parent().add_child(instance)
		current_mag -= 1
		_update_ammo_ui()


func add_ammo(amount) -> void:
	total_ammo += amount
	_update_ammo_ui()


func take_damage(amount):
	current_health -= amount
	current_health = max(current_health, 0)
	_update_health_bar()
	incombat = true
	timelasthit = 0.0
	if current_health <= 0:
		_death()


func _update_health_bar():
	if health_bar:
		health_bar.value = current_health


func _death():
	var game_over_scene = load("res://scenes/restart.tscn").instantiate()
	get_tree().root.add_child(game_over_scene)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
