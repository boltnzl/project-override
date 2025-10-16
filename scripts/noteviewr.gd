extends Control

@export var clue_text: String = "" 
@onready var clue_label: Label = $Label2

# Sets the label's text to current clue
func _ready():
	clue_label.text = clue_text

# Sets the clue text to display and unlocks mouse
func set_clue(text: String) -> void:
	clue_text = text
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if clue_label:
		clue_label.text = clue_text

# Returns the player back to the game upon pressing "Return" button
func _on_return_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()
