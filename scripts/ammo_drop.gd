extends Area3D

@export var amount: int = 10   
var picked_up: bool = false

# When player enters ammo drop area, adds random ammo to the player and in-game model disappears
func _on_body_entered(body: Node) -> void:
	if picked_up == true:
		return
	if body.is_in_group("player") and body.has_method("add_ammo"):
		picked_up = true
		body.add_ammo(amount)
		queue_free()
