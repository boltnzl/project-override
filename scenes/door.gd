extends Node3D

@onready var door_closed = $door
@onready var door_open = $dooropen2
var is_open = false

func _ready():
	if door_open:
		door_open.visible = false
	if door_closed:
		door_closed.visible = true

func open_door():
	if not is_open:
		is_open = true
		if door_closed:
			door_closed.visible = false
		if door_open:
			door_open.visible = true
