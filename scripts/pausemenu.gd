extends Control

@onready var health_stamina_ui = $"../Health_Stamina"
@onready var ammo_ui = $"../AmmoCounter"


func _ready():
	visible = false


func toggle_pause():
	if visible:
		get_tree().paused = false
		visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if health_stamina_ui:
			health_stamina_ui.visible = true
		if ammo_ui:
			ammo_ui.visible = true
	else:
		get_tree().paused = true
		visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if health_stamina_ui:
			health_stamina_ui.visible = false
		if ammo_ui:
			ammo_ui.visible = false


func _input(event):
	if event.is_action_pressed("escape") and not GameData.puzzle_open:
		toggle_pause()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_resume_pressed() -> void:
	toggle_pause()
