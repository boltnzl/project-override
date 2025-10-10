extends Node3D

var keypad_instance : Node = null
@onready var area = $Area3D
var player_close = false
@export var door_to_open: NodePath  
@export var passcode_for_level: String = ""




func _process(delta):
	if player_close and Input.is_action_just_pressed("use"):
		_open_keypad()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_close = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_close = false


func _open_keypad():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	GameData.puzzle_open = true
	get_tree().paused = true 
	keypad_instance = preload("res://keypad_puzzle.tscn").instantiate()
	get_tree().root.add_child(keypad_instance)
	keypad_instance.passcode = passcode_for_level
	if door_to_open != NodePath(""):
		var door_node = get_node(door_to_open)
		keypad_instance.door_node = door_node
