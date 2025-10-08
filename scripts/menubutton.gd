extends Control

@onready var button = $"."
@onready var background = $"../Polygon2D"

func _ready():
	background.modulate.a = 0.0 
	button.mouse_entered.connect(_on_hover)
	button.mouse_exited.connect(_on_exit)

func _on_hover():
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, 0.2)  
	button.add_theme_color_override("font_color", Color.BLACK)

func _on_exit():
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 0.0, 0.2)
	button.add_theme_color_override("font_color", Color.WHITE)
