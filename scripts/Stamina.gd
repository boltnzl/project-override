extends ProgressBar

# Stamina variables
var regen_delay = 0.5       
var regen_timer = 0.0
var minimum_stamina = 20.0             
var exhausted = false       
var drain_rate = 0.5
var regenerate = 0.4

# Sets the stamina bar to max upon the start
func _ready():
	value = max_value

# Handles the stamina bar logic
func _process(delta):
	# Drains the stamina bar if the player has more than 0 stamina and is pressing shift
	if Input.is_action_pressed("sprint") and value > 0 and !exhausted:
		value -= drain_rate
		regen_timer = 0.0
		# Stops draining when the stamina bar reaches 0
		if value <= 0:
			exhausted = true
	# Starts regenerating stamina 
	else:
		if regen_timer < regen_delay:
			regen_timer += delta
		elif value < max_value:
			value += regenerate 
			if exhausted and value >= minimum_stamina:
				exhausted = false
