class_name PlayerIdleState
extends State

func enter() -> void:
	player.sprite.modulate = Color8(245, 245, 245)

func process_state() -> State:
	if Input.get_axis("left", "right"):
		return player.states[1]
	if Input.is_action_just_pressed("jump"):
		return player.states[2]
	if Input.is_action_just_pressed("cast"):
		return player.states[3]
	return null
