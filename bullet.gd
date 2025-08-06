extends Node3D

const SPEED = 100.0

@onready var mesh = $MeshInstance3D
@onready var particles = $GPUParticles3D
@onready var ray = $RayCast3D

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	var distance = SPEED * delta
	ray.target_position = Vector3(0, 0, -distance)
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		mesh.visible = false
		particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()
dd
func _on_timer_timeout() -> void:
	queue_free()
