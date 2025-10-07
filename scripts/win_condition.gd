extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player" or get_tree().paused:
		return
	GameData.unlockedlevel = max(GameData.unlockedlevel, GameData.current_level + 1)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var win_screen = load("res://scenes/win_screen.tscn").instantiate()
	get_tree().current_scene.add_child(win_screen)
