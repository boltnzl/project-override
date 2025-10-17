extends Node3D

@export var target_door: NodePath
@export var computer_name: String = "Computer"
@export var clue_text: String = "Clue"
@export var is_correct: bool = false
var player_close: bool = false
@onready var area: Area3D = $Area3D
var interacted: bool = false
var door_node: Node = null  

# Checks if a door node path is assigned and retrieves the door node
func _ready() -> void:
	if target_door != null and has_node(target_door):
		door_node = get_node(target_door)

# Opens computer screen if player is near and presses the E key
func _process(delta: float) -> void:
	if player_close and Input.is_action_just_pressed("use"):
		_open_computer_screen()
		GameData.puzzle_open = true

# Pauses the game and loads the computer screen UI onto the screen
func _open_computer_screen():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var screen_scene = preload("res://scenes/computer_clue.tscn").instantiate()
	get_tree().root.add_child(screen_scene)
	get_tree().paused = true
	screen_scene.set_clue(clue_text, computer_name, is_correct, self)

# Detects if the player is near the computer and if they have not completed the puzzle
func _on_detect_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not interacted:
		player_close = true

# Detects if the player has exited the area near the computer
func _on_detect_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_close = false
