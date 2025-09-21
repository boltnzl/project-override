extends Control

@onready var restart_button: Button = $Button

func _ready():
	restart_button.pressed.connect(_on_restart_pressed)

func _on_restart_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()
	get_tree().change_scene_to_file("res://level.tscn")
