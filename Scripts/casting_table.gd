extends Area2D

func _on_body_entered(body: Node2D):
	if body is Player:
		var player: Player = body
		player.able_to_cast = true

func _on_body_exited(body: Node2D):
	if body is Player:
		var player: Player = body
		player.able_to_cast = false
