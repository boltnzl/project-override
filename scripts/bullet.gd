extends Node3D

const SPEED = 100.0
@onready var mesh = $MeshInstance3D
@onready var particles = $GPUParticles3D
@onready var ray = $RayCast3D


func _ready() -> void:
	particles.one_shot = true
	particles.emitting = false


func _physics_process(delta: float) -> void:
	var distance = SPEED * delta
	ray.target_position = Vector3(0, 0, -distance)
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	
	if ray.is_colliding():
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		if ray.get_collider().is_in_group("enemy"):
			ray.get_collider().hit(1.0)
			await get_tree().create_timer(particles.lifetime).timeout
		queue_free()
