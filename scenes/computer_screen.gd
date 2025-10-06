extends Control

@onready var clue_label = $Panel/Label
@onready var close_button = $Panel/Button

func _ready():
	close_button.pressed.connect(_on_close_pressed)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_clue(text: String):
	clue_label.text = text

func _on_close_pressed():
	get_tree().paused = false
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
