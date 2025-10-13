extends Control

@export var clue_text: String = "" 
@onready var clue_label = $Label2


func _ready():
	clue_label.text = clue_text


func set_clue(text: String) -> void:
	clue_text = text
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if clue_label:
		clue_label.text = clue_text


func _on_return_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()
