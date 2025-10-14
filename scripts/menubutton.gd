extends Control

# Button variables
@onready var button = $"."
@onready var background = $"../Polygon2D"

# Changes the background of the button to transparent and connects hover and exit 
func _ready():
	background.modulate.a = 0.0 
	button.mouse_entered.connect(_on_hover)
	button.mouse_exited.connect(_on_exit)

# Changes the background colour to white upon hovering and changes the font colour to black
func _on_hover():
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, 0.2)  
	button.add_theme_color_override("font_color", Color.BLACK)

# Changes the background colour to transparent when moving mouse off button and changes font 
# colour to black
func _on_exit():
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 0.0, 0.2)
	button.add_theme_color_override("font_color", Color.WHITE)
