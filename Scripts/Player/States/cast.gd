class_name PlayerCastState
extends State

func enter() -> void:
	player.sprite.modulate = Color8(0, 0, 255)

func process_state() -> State:
	if Input.is_action_just_pressed("cast"):
		return player.states[0]
	return null
