extends Control

# Redirects the player to the main menu and
func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")



# Restarts the level the player is currently on when the "Restart" button is pressed
func _on_restart_pressed() -> void:
	get_tree().paused = false
	queue_free()
	if GameData.current_level == 1:
		get_tree().change_scene_to_file("res://scenes/level.tscn")
	elif GameData.current_level == 2:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
	elif GameData.current_level == 3:
		get_tree().change_scene_to_file("res://scenes/level_3.tscn")
 
