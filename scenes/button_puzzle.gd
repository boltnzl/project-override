extends Node3D

@export var door_to_open: NodePath   
@export var button_mesh: NodePath    
@onready var area = $Area3D
var player_near: bool = false
var door_node: Node = null


func _ready():
	if door_to_open and has_node(door_to_open):
		door_node = get_node(door_to_open)


func _process(delta: float) -> void:
	if player_near and Input.is_action_just_pressed("use"):
		_press_button()


func _press_button():
	if door_node:
		if door_node.has_method("open_door"):
			door_node.call("open_door")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_near = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_near = false
