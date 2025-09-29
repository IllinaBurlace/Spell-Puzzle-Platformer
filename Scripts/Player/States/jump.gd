class_name PlayerJumpState
extends State

func enter() -> void:
	player.sprite.modulate = Color8(0, 255, 0)

func process_state() -> State:
	if player.is_on_floor():
		return player.states[0]
	return null
