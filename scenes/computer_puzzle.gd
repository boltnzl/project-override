extends Node3D

@export var clue_text : String = "Default clue" 
var player_close: bool = false
@onready var area = $Area3D


func _ready():
	area.body_entered.connect(_on_area_body_entered)
	area.body_exited.connect(_on_area_body_exited)


func _on_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_close = true


func _on_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_close = false


func _process(delta: float) -> void:
	if player_close and Input.is_action_just_pressed("use"): 
		_open_computer_screen()


func _open_computer_screen():
	get_tree().paused = true  
	var screen_scene = preload("res://scenes/computer_clue.tscn").instantiate()
	get_tree().root.add_child(screen_scene)
	screen_scene.set_clue(clue_text)  
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
