extends Control


@onready var clue_label: RichTextLabel = $Panel/RichTextLabel
@onready var computer_label: Label = $Panel/Label2
@onready var accept: Button = $Accept
var correct: bool = false
var computer_node: Node = null
@export var restart_scene_path: String = "res://scenes/restart_scene.tscn"

# Sets the clue for the computer screen via the inspector
func set_clue(clue_text: String, comp_name: String, is_correct: bool, comp_node: Node):
	clue_label.text = clue_text
	computer_label.text = comp_name
	correct = is_correct
	computer_node = comp_node

# When accept button is pressed, checks if the player has chosen the correct computer. 
# If they have, opens the next door. If they haven't, restarts the player
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

# Returns the player back to the game upon pressing the "Return" button
func _on_return_pressed() -> void:
	get_tree().paused = false
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Checks if the player has pressed the Escape key and makes them return to the game
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		GameData.puzzle_open = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
		_return_to_game()

# Returns the player back to the game upon pressing escape key
func _return_to_game():
	get_tree().paused = false
	queue_free()
