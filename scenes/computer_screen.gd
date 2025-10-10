extends Control

@onready var clue_label = $Panel/Label
@onready var computer_label = $Panel/Label2
@onready var accept = $Accept
var correct: bool = false
var computer_node: Node = null
@export var restart_scene_path: String = "res://scenes/restart_scene.tscn"


func _ready():
	show()
	accept.pressed.connect(_on_accept_pressed)


func set_clue(clue_text: String, comp_name: String, is_correct: bool, comp_node: Node):
	clue_label.text = clue_text
	computer_label.text = comp_name
	correct = is_correct
	computer_node = comp_node


func _on_accept_pressed() -> void:
	get_tree().paused = false
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if correct and computer_node:
		if computer_node.door_node and computer_node.door_node.has_method("open_door"):
			computer_node.door_node.call("open_door")
		computer_node.interacted = true
	else:
		var restart_scene = load("res://scenes/restart.tscn")
		get_tree().change_scene_to_packed(restart_scene)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_return_pressed() -> void:
	get_tree().paused = false
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
