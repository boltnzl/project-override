extends Control

func _ready() -> void:
	$"HBoxContainer/Level 1".pressed.connect(_on_level1_pressed)
	$"HBoxContainer/Level 2".pressed.connect(_on_level2_pressed)
	$"HBoxContainer/Level 3".pressed.connect(_on_level3_pressed)


func _on_level1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_level2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_level3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_3.tscn")
