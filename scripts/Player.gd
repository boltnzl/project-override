extends CharacterBody3D

class_name Player 

#@onready var obj1 = $Node2D/Level1Objectives
#@onready var obj2 = $Node2D/Level2Objectives
#@onready var obj3 = $Node2D/Level3Objectives

# Movement variables
const SHAKE_FREQUENCY = 1.5
const SHAKE_AMPLITUDE = 0.06
const WALK_SPEED = 10.0
const SPRINT_SPEED = 20.0
const JUMP_VELOCITY = 10.0
const SENSITIVITY = 0.003

# Movement constants
var speed 
var gravity = 20
var field_of_view = 0.0

# Camera 
@onready var camera_pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D

# Health Bar 
@export var max_health: float = 100
@export var regen_delay = 3.0      
@export var regen_rate = 10.0 
var current_health: float
var in_combat = false
var time_last_hit = 0.0
@onready var health_bar = $"Health_Stamina/Health Bar"

# Stamina Bar
@onready var stamina : ProgressBar = $"Health_Stamina/Stamina Bar"

# Shooting
@export var max_mag = 25
@export var total_ammo = 100  
var bullet = load("res://scenes/bullet.tscn")
var instance
var current_mag = max_mag     
var reload_time = 2.0
var is_reloading = false 
@onready var magazine_label = $AmmoCounter/Magazine
@onready var ammo_label = $AmmoCounter/Ammo
@onready var gun_animation = $Pivot/Camera3D/Pistol/AnimationPlayer
@onready var gun_barrel = $Pivot/Camera3D/Pistol/RayCast3D

# Knockback 
@export var knockback_force = 30
@export var knockback_duration = 0.2
var knockback_velocity = Vector3.ZERO
var knockback_time = 0.0

# Initializies player variables 
func _ready():
	#update_objectives()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	speed = WALK_SPEED
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health

# Handles mouse movement which controls the rotation of the camera
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_pivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

# Physics and Movement
func _physics_process(delta: float) -> void:
	if knockback_time > 0:
		velocity = knockback_velocity
		knockback_time -= delta
	else:
		if not is_on_floor():
			velocity.y -= gravity * delta 
	
	# Allows the player to speed up movement while holding down shift
	if Input.is_action_pressed("sprint"):
		if stamina.value > 0:
			speed = SPRINT_SPEED
		else:
			speed = SPRINT_SPEED
	
	# Allows the player to jump when pressing space
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Allows the player to reload their gun by pressing R
	if Input.is_action_just_pressed("reload"):
		_reload()
	
	# Gets input direction via WASD keys
	var input_direction := Input.get_vector("left", "right", "up", "down")
	var direction := (camera_pivot.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	# Applies movement to the player
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		# Applies mid-air physics to the player
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0) 
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# Applies the bobbing effect while moving around
	field_of_view += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(field_of_view)
	
	# Allows the player to shoot bullets when pressing left click
	if Input.is_action_pressed("shoot"):
		_shoot()
	  
	# Regenerates the player's health after a period of time of no damage taken
	if not in_combat:
		time_last_hit += delta
		if time_last_hit >= regen_delay and current_health < max_health:
			current_health = min(current_health + regen_rate * delta, max_health)
			_update_health_bar()
	else:
		time_last_hit += delta
		if time_last_hit >= regen_delay:
			in_combat = false
	move_and_slide()

# Applies bobbing to the player movement
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * SHAKE_FREQUENCY)* SHAKE_AMPLITUDE
	pos.x = cos(time * SHAKE_FREQUENCY/2) * SHAKE_AMPLITUDE
	return pos

# Applies knockback to the player when being hit by an enemy
func apply_knockback(from_position: Vector3) -> void:
	var direction = (global_position - from_position).normalized()
	knockback_velocity = direction * knockback_force
	knockback_velocity.y = 5
	knockback_time = knockback_duration

# Reloads the gun if magazine isn't full and ammo is available, then updates ammo UI
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

# Updates the player's ammo in the UI
func _update_ammo_ui():
	magazine_label.text = str(total_ammo)
	ammo_label.text = str(current_mag)

# Fires a bullet if not reloading and ammo is avaliable, then updates ammo UI
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

# Gives the player ammo and updates ammo UI 
func add_ammo(amount) -> void:
	total_ammo += amount
	_update_ammo_ui()

# Decreass health, updates UI, and handles death if health reaches 0 
func take_damage(amount):
	current_health -= amount
	current_health = max(current_health, 0)
	_update_health_bar()
	in_combat = true
	time_last_hit = 0.0
	if current_health <= 0:
		_death()

# Updates the player's health bar
func _update_health_bar():
	if health_bar:
		health_bar.value = current_health

# Handles player's death and loads the restart screen upon death
func _death():
	var game_over_scene = load("res://scenes/restart.tscn").instantiate()
	get_tree().root.add_child(game_over_scene)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
#func update_objectives():
	#obj1.visible = false
	#obj2.visible = false
#	obj3.visible = false

	#match GameData.current_level:
		#1:
			#obj1.visible = true
		#2:
			#obj2.visible = true
		#3:
			#obj3.visible = true
