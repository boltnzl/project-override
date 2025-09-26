extends ProgressBar

@export var player: Player

func _ready():
	Player

func update():
	value = player.currentHealth  * 100 / player.maxHealth
