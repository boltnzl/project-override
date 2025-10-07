extends ProgressBar

@export var player: Player

func _process(delta):
	if player:
		value = player.current_health * 100 / player.max_health
