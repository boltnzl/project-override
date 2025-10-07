extends Control

@onready var button = $"."
@onready var bg = $"../Polygon2D"
@onready var anim = $"../AnimationPlayer"


func _ready():
	button.mouse_entered.connect(_on_hover)
	button.mouse_exited.connect(_on_exit)

func _on_hover():
	anim.play("fade_in")

func _on_exit():
	anim.play_backwards("hover")
