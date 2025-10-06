extends Node

var puzzle_open = false
var current_level: = 1
var unlockedlevel: = 1

func unlocked(level) -> void:
	if level > unlockedlevel:
		unlockedlevel = level
