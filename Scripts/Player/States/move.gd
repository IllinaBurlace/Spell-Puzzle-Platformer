class_name PlayerMoveState
extends State

func enter() -> void:
	player.sprite.modulate = Color8(255, 0, 0)

func process_state() -> State:
	if !Input.get_axis("left", "right"):
		return player.states[0]
	if Input.is_action_just_pressed("jump"):
		return player.states[2]
	return null
