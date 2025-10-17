extends Control

# Button variables
@onready var button: Button = $"."
@onready var background: Polygon2D = $"../Polygon2D"

# Changes the background of the button to transparent and connects hover and exit 
func _ready():
	background.modulate.a = 0.0 
	button.mouse_entered.connect(_on_hover)
	button.mouse_exited.connect(_on_exit)

# Changes the background colour to white upon hoveringd
func _on_hover():
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, 0.2)  

# Changes the background colour to transparent when moving mouse off button
func _on_exit():
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 0.0, 0.2)
