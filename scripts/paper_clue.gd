extends Node3D

@export var clue_text: String = ""
var player_close: bool = false

# Opens the note if the player is near the model and is pressing  the E key
func _process(delta):
	if player_close and Input.is_action_just_pressed("use"):
		open_clue()

# Shows the note on the screen when called and pauses the game
func open_clue():
	var clue_ui = preload("res://scenes/noteviewr.tscn").instantiate()
	clue_ui.set_clue(clue_text) 
	get_tree().root.add_child(clue_ui)
	get_tree().paused = true

# Checks if the player is in the area of the note and allows the player to open the note
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_close = true

# Checks if the player has exited the area of the note and prevents them from opening the note
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_close = false
