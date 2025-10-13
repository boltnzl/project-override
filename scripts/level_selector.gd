extends Control

func _ready() -> void:
	if GameData.unlockedlevel >= 2:
		$"HBoxContainer/Level2/Level 2".disabled = false
	else:
		$"HBoxContainer/Level2/Level 2".disabled = true
	if GameData.unlockedlevel >= 3:
		$"HBoxContainer/Level3/Level 3".disabled = false
	else:
		$"HBoxContainer/Level3/Level 3".disabled = true


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_3.tscn")


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
