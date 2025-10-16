extends Control


var door_node: Node = null 
var typed_text : String
@export var passcode: String = "1234"
@export var door_to_open: NodePath  
var timer: Timer = Timer.new()
@onready var label : RichTextLabel = $RichTextLabel
@onready var square : Sprite2D = $Sprite2D
@export var return_scene_path: String = "res://scenes/level.tscn"

# Sets up the timer settings when the node is ready
func _ready() -> void:
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_Timeout)
	add_child(timer)

# Checks if the player has pressed the Escape key and makes them return to the game
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		GameData.puzzle_open = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
		_return_to_game()

# Clears the typed text when the timer finishes
func _on_timer_Timeout():
	typed_text = ""
	label.text = typed_text

# Allows the player to enter the number 1 upon pressing the button
func _on_1_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "1"
		label.text = typed_text

# Allows the player to enter the number 2 upon pressing the button
func _on_2_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "2"
		label.text = typed_text

# Allows the player to enter the number 3 upon pressing the button
func _on_3_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "3"
		label.text = typed_text

# Allows the player to enter the number 4 upon pressing the button
func _on_4_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "4"
		label.text = typed_text

# Allows the player to enter the number 5 upon pressing the button
func _on_5_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "5"
		label.text = typed_text

# Allows the player to enter the number 6 upon pressing the button
func _on_6_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "6"
		label.text = typed_text

# Allows the player to enter the number 7 upon pressing the button
func _on_7_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "7"
		label.text = typed_text

# Allows the player to enter the number 8 upon pressing the button
func _on_8_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "8"	
		label.text = typed_text

# Allows the player to enter the number 9 upon pressing the button
func _on_9_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "9"
		label.text = typed_text

# Allows the player to enter the number 0 upon pressing the button
func _on_0_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "0"
		label.text = typed_text

# Allows the player to clear their keypad answer
func _on_clear_pressed() -> void:
	typed_text = ""
	label.text = typed_text

# Allows the player to enter their keypad answer and detects if the answer is correct or not
# If correct, will open the next door. If incorrect, will load restart scene
func _on_enter_pressed() -> void:
	if typed_text == passcode:
		typed_text = "Correct"
		label.text = typed_text
		timer.start(0.5)
		if door_node and door_node.has_method("open_door"):
			door_node.call("open_door")
	else :
		typed_text = "Incorrect"
		label.text = typed_text
		var restart_scene = load("res://scenes/restart.tscn")
		queue_free()
		get_tree().change_scene_to_packed(restart_scene)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Returns the player back to the game upon pressing escape key
func _return_to_game():
	get_tree().paused = false
	queue_free()
