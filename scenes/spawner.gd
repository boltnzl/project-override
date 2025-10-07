extends Node3D


@export var enemy_scene: PackedScene
@export var spawn_points_group: String = "SpawnPoints"


func _ready():
	var spawns = get_tree().get_nodes_in_group(spawn_points_group)
	for spawn in spawns:
		if spawn and spawn is Marker3D:
			var enemy = enemy_scene.instantiate()
			enemy.global_position = spawn.global_transform.origin
			add_child(enemy)
