extends Control

@onready var restart: Button = $Button

func _ready():
	restart.pressed.connect(restart_pressed)

func restart_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()
	get_tree().change_scene_to_file("res://level.tscn")
