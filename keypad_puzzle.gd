extends Control

var typed_text : String
var passcode : String = "5219"
var timer = Timer.new()
@onready var label : RichTextLabel = $VBoxContainer/RichTextLabel
@onready var square : Sprite2D = $Sprite2D
@export var return_scene_path: String = "res://scenes/level.tscn"

func _ready() -> void:
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_Timeout)
	add_child(timer)


func _process(delta):
	if Input.is_action_just_pressed("escape"):
		GameData.puzzle_open = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
		_return_to_game()


func _on_timer_Timeout():
	square.modulate = Color (1,1,1)
	typed_text = ""
	label.text = typed_text


func _on_1_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "1"
		label.text = typed_text


func _on_2_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "2"
		label.text = typed_text


func _on_3_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "3"
		label.text = typed_text


func _on_4_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "4"
		label.text = typed_text


func _on_5_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "5"
		label.text = typed_text


func _on_6_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "6"
		label.text = typed_text


func _on_7_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "7"
		label.text = typed_text


func _on_8_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "8"	
		label.text = typed_text


func _on_9_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "9"
		label.text = typed_text


func _on_0_pressed() -> void:
	if typed_text.length() < 4:
		typed_text += "0"
		label.text = typed_text


func _on_clear_pressed() -> void:
	typed_text = ""
	label.text = typed_text


func _on_enter_pressed() -> void:
	if typed_text == passcode:
		square.modulate = Color(0,1,0)
		typed_text = "Correct"
		label.text = typed_text
		timer.start(0.5)
	else :
		square.modulate = Color(1,0,0)
		typed_text = "Incorrect"
		label.text = typed_text
		timer.start(0.5)


func _return_to_game():
	get_tree().paused = false
	queue_free()
