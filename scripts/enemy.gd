extends CharacterBody3D

var player: Player = null
const SPEED = 10.0
@export var playerlocation: NodePath
@onready var pathfinder: NavigationAgent3D = $NavigationAgent3D
@onready var progress: ProgressBar = $"../Player/Health_Stamina/Health Bar"
@export var maxhealth = 100
@export var damage = 10                  
@export var regenrate = 5.0         
@export var regendelay = 10.0          
var timelasthit = 0.0
var incombat = false
var health = 10.0
var damagehit = 1.0


func _ready() -> void:
	player = get_node(playerlocation)
	progress.max_value = maxhealth
	progress.value = maxhealth


func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	pathfinder.set_target_position(player.global_transform.origin)
	var nextpos = pathfinder.get_next_path_position()
	velocity = (nextpos - global_transform.origin).normalized() * SPEED
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	move_and_slide()
   
	if not incombat:
		timelasthit += delta
		if timelasthit >= regendelay and progress.value < maxhealth:
			progress.value = min(progress.value + regenrate * delta, maxhealth)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		progress.value -= damage
		if progress.value <= 0:
			progress.value = 0
			kill_player()

		if body.has_method("apply_knockback"):
			body.apply_knockback(global_position)

		incombat = true
		timelasthit = 0.0


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		incombat = false

func kill_player() -> void:
	var game_over_scene = load("res://scenes/restart.tscn").instantiate()
	get_tree().root.add_child(game_over_scene) 
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func hit() -> void:
		health -= damagehit
		progress.value = health
		incombat = true
		timelasthit = 0.0
		if health <= 0:
			give_player_ammo(10)
			queue_free()


func give_player_ammo(amount) -> void:
	if player and player.has_method("add_ammo"):
		player.add_ammo(amount)
