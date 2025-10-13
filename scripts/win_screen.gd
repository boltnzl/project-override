extends Control

# Unpauses the game and switches to level selector scene
func _on_continue_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")

# Unpauses the game and restarts current level
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

# Unpauses the game and switches to main menu scene
func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
