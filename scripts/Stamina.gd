extends ProgressBar

var can_regen = false
var regen_delay = 0.5
var regen_timer = 0.0


# Sets max value at the start of game
func _ready():
    value = max_value


# Sets max value at the start of game
func _process(delta):
    if Input.is_action_pressed("sprint") and value > 0:
        value -= 0.5
        can_regen = false
        regen_timer = 0.0
    
    else:
        if !can_regen:
            regen_timer += delta
            if regen_timer >= regen_delay:
                can_regen = true
        
        if can_regen and value < max_value:
            value += 0.4
