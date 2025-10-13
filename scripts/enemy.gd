extends CharacterBody3D

const SPEED = 10.0
@export var maxhealth = 10.0
@export var damage = 10.0
var enemy_health = maxhealth
var is_chasing = false
var timelasthit = 0.0
var incombat = false
const AMMO_PICKUP_SCENE = preload("res://scenes/ammo_drop.tscn")
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var aggro_area: Area3D = $AggroArea
var player: Player = null


func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0] as Player


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


func hit(amount) -> void:
	if enemy_health <= 0:
		return  
	enemy_health -= amount
	if enemy_health <= 0:
		var pickup = AMMO_PICKUP_SCENE.instantiate()
		get_tree().current_scene.add_child(pickup)
		pickup.global_position = global_position + Vector3(0, 0.5, 0)
		pickup.amount = randi_range(5, 15)
		queue_free()


func _drop_ammo() -> void:
	var pickup = AMMO_PICKUP_SCENE.instantiate()
	pickup.global_transform = global_transform
	pickup.amount = randi_range(5, 15)
	get_parent().add_child(pickup)


func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_chasing = true
		incombat = true
		timelasthit = 0.0


func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_chasing = false
		incombat = false


func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		if body.has_method("apply_knockback"):
			body.apply_knockback(global_position)
