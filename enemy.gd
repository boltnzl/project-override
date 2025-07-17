extends CharacterBody3D


@onready var area = $NavigationRegion3D
var speed = 10.0
var gravity = 5


func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	var position1 = area.get_next_path_position()
	var position2 = global_transform.origin
	var velocity2 = (position1 - position2).normalized() * speed
	
	velocity = velocity.move_toward(velocity2, 0.25)
	move_and_slide()
	
func target_position(target):
	area.position2 = target
  
