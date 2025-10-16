extends Node3D

@export var door_to_open: NodePath   
@export var button_mesh: NodePath    
@onready var area: Area3D = $Area3D
var player_near: bool = false
var door_node: Node = null

# Checks if a door node path is assigned and retrieves the door node
func _ready():
	if door_to_open and has_node(door_to_open):
		door_node = get_node(door_to_open)

# Opens the next door if the player is in the area of the button and presses the E key
func _process(delta: float) -> void:
	if player_near and Input.is_action_just_pressed("use"):
		_press_button()

# Calls to open the door
func _press_button():
	if door_node:
		if door_node.has_method("open_door"):
			door_node.call("open_door")

# Detects if the player is in the area of the button
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_near = true

# Detects when the player is not in the area of the button
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_near = false
