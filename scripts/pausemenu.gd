extends Control

@onready var health_stamina_ui = $"../Health_Stamina"
@onready var ammo_ui = $"../AmmoCounter"

# Hides pause menu upon start
func _ready():
	visible = false

# Displays pause menu if not already visible and unlocks mouse. If visible, hides pause menu and 
# locks mouse
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

# Toggles the pause menu if the player presses Esc and isn't in a puzzle
func _input(event):
	if event.is_action_pressed("escape") and not GameData.puzzle_open:
		toggle_pause()

# Switches the player to main menu upon clicking the "Main Menu" button
func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

# Resumes the player's gameplay upon clicking the "Resume" button
func _on_resume_pressed() -> void:
	toggle_pause()
