extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if GameData.unlockedlevel < 2: 
			GameData.unlockedlevel = 2
		elif GameData.unlockedlevel < 3: 
			GameData.unlockedlevel = 3
