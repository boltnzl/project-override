extends Node3D

@export var clue_text: String = ""
var player_close = false


func _process(delta):
	if player_close and Input.is_action_just_pressed("use"):
		open_clue()


func open_clue():
	var clue_ui = preload("res://noteviewr.tscn").instantiate()
	clue_ui.set_clue(clue_text) 
	get_tree().root.add_child(clue_ui)
	get_tree().paused = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_close = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_close = false
