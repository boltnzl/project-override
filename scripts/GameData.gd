extends Node

var unlockedlevel: = 1

func unlocked(level) -> void:
	if level > unlockedlevel:
		unlockedlevel = level
