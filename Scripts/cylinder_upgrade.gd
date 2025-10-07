extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.cylinder.grow_queue()
		queue_free()
