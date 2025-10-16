extends Node3D


@onready var door_closed_node: Node3D = $door
@onready var door_closed_collision: StaticBody3D = $door/StaticBody3D
@onready var door_open_mesh: Node3D = $dooropen2
var is_open: bool = false

# Shows the closed door model upon start
func _ready():
	if door_closed_node:
		door_closed_node.show()
	if door_closed_collision:
		door_closed_collision.visible = true
	if door_open_mesh:
		door_open_mesh.hide()

# Shows the model of the open door if not already open
func open_door():
	if is_open:
		return
	is_open = true
	if door_closed_node:
		door_closed_node.hide()
	if door_closed_collision:
		door_closed_collision.queue_free()  
	if door_open_mesh:
		door_open_mesh.show()
