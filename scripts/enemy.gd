extends CharacterBody3D


const SPEED: float = 10.0
const AMMO_PICKUP_SCENE: PackedScene = preload("res://scenes/ammo_drop.tscn")

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var aggro_area: Area3D = $AggroArea

var player: Player = null
var is_chasing: bool = false

@export var damage: float = 50.0
@export var maxhealth: float = 10.0
var enemy_health: float = maxhealth

var timelasthit: float = 0.0
var incombat: bool = false


# Stores the player node from the player group
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0] as Player

# Handles enemy movement and animation while chasing the player
func _physics_process(delta: float) -> void:
	if is_chasing and player:
		var dir = player.global_transform.origin - global_transform.origin
		dir.y = 0
		if dir.length() > 0.1:
			velocity = dir.normalized() * SPEED
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			if anim and anim.current_animation != "Run":
				anim.play("Run")
		else:
			velocity = Vector3.ZERO
			if anim and anim.current_animation != "Idle":
				anim.play("Idle")
	else:
		velocity = Vector3.ZERO
		if anim and anim.current_animation != "Idle":
			anim.play("Idle")
	move_and_slide()

# Checks if the enemy's health is 0, if so, will spawn an ammo drop model on the zombie and then 
# will despawn
func hit(amount) -> void:
	enemy_health -= amount
	print(enemy_health)
	if enemy_health <= 0:
		var pickup = AMMO_PICKUP_SCENE.instantiate()
		get_tree().current_scene.add_child(pickup)
		pickup.global_position = global_position + Vector3(0, 0.5, 0)
		pickup.amount = randi_range(5, 15)
		queue_free()

# Spawns ammo onto the ground for the player to pick up
func _drop_ammo() -> void:
	var pickup = AMMO_PICKUP_SCENE.instantiate()
	pickup.global_transform = global_transform
	pickup.amount = randi_range(5, 15)
	get_parent().add_child(pickup)

# Detects when the player is in range to chase
func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_chasing = true
		incombat = true
		timelasthit = 0.0

# Detects when the player is out of range to chase
func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_chasing = false
		incombat = false

# Detects when the player is in range to attack
func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		if body.has_method("apply_knockback"):
			body.apply_knockback(global_position)
