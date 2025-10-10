extends Node3D

@onready var door_closed_mesh = $"../Door2/door"
@onready var door_closed_collision = $"../Door2/door/StaticBody3D/CollisionShape3D"
@onready var door_open_mesh = $"../Door2/dooropen2"

var is_open = false

func _ready():
	if door_closed_mesh:
		door_closed_mesh.show()
	if door_closed_collision:
		door_closed_collision.visible = true 
	if door_open_mesh:
		door_open_mesh.hide()


func open_door():
	if is_open:
		return
	is_open = true


	if door_closed_mesh:
		door_closed_mesh.hide()
	if door_closed_collision:
		door_closed_collision.queue_free()
	if door_open_mesh:
		door_open_mesh.show()
