extends Control

# Detects which levels the player has unlocked and locks levels that have not be unlocked
func _ready() -> void:
	if GameData.unlockedlevel >= 2:
		$"HBoxContainer/Level2/Level 2".disabled = false
	else:
		$"HBoxContainer/Level2/Level 2".disabled = true
	if GameData.unlockedlevel >= 3:
		$"HBoxContainer/Level3/Level 3".disabled = false
	else:
		$"HBoxContainer/Level3/Level 3".disabled = true

# Switches the player to level 1 upon clicking the "1" button
func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

# Switches the player to level 2 upon clicking the "2" button
func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

# Switches the player to level 3 upon clicking the "3" button
func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_3.tscn")

# Returns the player back to the main menu upon clicking the "RETURN" button
func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
