extends Control

# Switches the player to the level selector upon pressing the "Play" button
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")

# Quits the game for the player upon pressing the "Quit" button
func _on_quit_pressed() -> void:
	get_tree().quit()
