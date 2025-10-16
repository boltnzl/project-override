extends Control

@export var objectives_container_path: NodePath
@export var objective_scenes: Array = [
	preload("res://scenes/objectives.tscn"),
	preload("res://scenes/level_2_objectives.tscn"),
	preload("res://scenes/level_3_objectives.tscn")
]

# Runs when entering a level and shows player's current objectives, updating if the level changes
func _ready() -> void:
	await get_tree().process_frame
	show_objective(GameData.current_level)
	if GameData.has_signal("level_changed"):
		GameData.level_changed.connect(show_objective)

# Clears any existing objects in the container and displays the objectives corresponding to the 
# level
func show_objective(level: int) -> void:
	var container = get_node_or_null(objectives_container_path)
	if not container:
		return
	for child in container.get_children():
		child.queue_free()
	if level - 1 < objective_scenes.size():
		var instance = objective_scenes[level - 1].instantiate()
		container.add_child(instance)
