extends ProgressBar

var regen_delay = 0.5       
var regen_timer = 0.0
var min = 20.0             
var exhausted = false       

var drainrate = 0.5
var regenerate = 0.4

func _ready():
	value = max_value

func _process(delta):
	if Input.is_action_pressed("sprint") and value > 0 and !exhausted:
		value -= drainrate
		regen_timer = 0.0
		if value <= 0:
			exhausted = true
	else:
		if regen_timer < regen_delay:
			regen_timer += delta
		elif value < max_value:
			value += regenerate 
			if exhausted and value >= min:
				exhausted = false
