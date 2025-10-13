extends Area3D

@export var amount = 10   
var picked_up = false


# When player enters ammo drop area, adds random ammo to the player.
func _on_body_entered(body: Node) -> void:
	if picked_up == true:
		return
	if body.is_in_group("player") and body.has_method("add_ammo"):
		picked_up = true
		body.add_ammo(amount)
		queue_free()
