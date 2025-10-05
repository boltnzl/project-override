extends Control

@onready var main_menu_button = $"VBoxContainer/MainMenuNode/Main Menu"
@onready var restart_button = $VBoxContainer/RestartNode/Restart
@onready var level_selector_button = $VBoxContainer/PlayNode/Continue


func _ready():
	level_selector_button.pressed.connect(_on_continue_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	print("Main Menu pressed!")

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	print("Restart pressed!")

func _on_continue_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")
	print("Continue pressed!")
