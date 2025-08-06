extends CharacterBody3D

var player = null

const speed = 5.0
@export var playerlocation : NodePath
@onready var path_finder = $NavigationAgent3D


func _ready() -> void:
	player = get_node(playerlocation)


func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	path_finder.set_target_position(player.global_transform.origin)
	var nextpathfinder = path_finder.get_next_path_position()
	velocity = (nextpathfinder - global_transform.origin).normalized() * speed
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	move_and_slide()
	
