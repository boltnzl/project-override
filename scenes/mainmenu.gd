extends Control


func _ready() -> void:
	$HBoxContainer/VBoxContainer/Play.pressed.connect(_on_play_pressed)
	$HBoxContainer/VBoxContainer/Quit.pressed.connect(_on_quit_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
