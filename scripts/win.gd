extends Control

# Unpauses the game and switches to main menu scene upon pressing the "Main Menu" button
func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

# Restarts the current level upon pressing the "Restart" button
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

# Unpauses the game and switches to level selector scene upon pressing the "Level Selector" button
func _on_continue_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")
