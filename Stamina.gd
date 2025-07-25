extends ProgressBar

@onready var stamina = $"."
var  can_regen = false
var time_to_wait = 1.5
var s_timer = 0
var can_start_timer = true


func _ready() -> void:
	stamina.value = stamina.max_value

func _process(delta: float) -> void:
	if can_regen == false && stamina.value != 10 or stamina.value == 0:
		can_start_timer = true
		if can_start_timer:
			s_timer += delta
			if s_timer >= time_to_wait:
				can_regen = true
				can_start_timer = true
				s_timer = 0
				
	if stamina.value == 10:
		can_regen = false
		
	if can_regen == true:
		stamina.value +=0.025	
		can_start_timer = false
		s_timer = 0
	
	
	if Input.is_action_pressed("sprint"):
		if stamina.value > 0:
			stamina.value -= 0.15 
			can_regen = false
			s_timer = 0
	else: 
		if !can_regen:
			s_timer += delta
			if s_timer >= time_to_wait:
				can_regen = true
		if can_regen and value < max_value:
			value += 0.025
		
