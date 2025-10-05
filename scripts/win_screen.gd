extends Control

@onready var main_menu_button = $"VBoxContainer/Main Menu"
@onready var restart_button = $VBoxContainer/Restart
@onready var level_selector_button = $VBoxContainer/Continue


func _ready():
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	level_selector_button.pressed.connect(_on_continue_pressed)


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_continue_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")
