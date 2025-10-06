extends Control


@onready var resume_button = $Panel/VBoxContainer/Resume
@onready var settings_button = $Panel/VBoxContainer/Settings
@onready var main_menu_button = $"Panel/VBoxContainer/Main Menu"


func _ready():
	visible = false
	resume_button.pressed.connect(_on_resume_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)


func _on_resume_pressed():
	toggle_pause() 


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_main_menu_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func toggle_pause():
	if visible:
		get_tree().paused = false
		visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	else:
		get_tree().paused = true
		visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 


func _input(event):
	if event.is_action_pressed("escape") and not GameData.puzzle_open:
		toggle_pause()
