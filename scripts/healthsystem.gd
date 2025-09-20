extends Node

signal on_change (current : int,max : int)
signal on_take_change ()
signal die ()

enum Death {DestroyNode, RestartScene}

var current : int
@export var max : int = 100

@export var death_action: Death
@export var drop : PackedScene


func ready():
	current = max

func take_damage(amount : int):
	current -= amount 
	on_change.emit(current, max)
	on_take_change.emit()
	
	if current <= 0:
		die()
	


	func die ():
		pass

func heal (amount : int):
	passs
