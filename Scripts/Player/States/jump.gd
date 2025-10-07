class_name PlayerJumpState
extends State

var entry_y: float = 0

func enter() -> void:
	player.sprite.modulate = Color8(0, 255, 0)
	entry_y = player.position.y
	player.velocity.y -= 500

func process_frame(_delta: float) -> void:
	if Input.is_action_just_pressed("spell"):
		player.cylinder.cast()

func process_phys(_delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	player.velocity.x = direction * 200

func process_state() -> State:
	if player.is_on_floor() and player.velocity.y >= 0:
		return player.states[0]
	return null
