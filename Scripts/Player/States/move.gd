class_name PlayerMoveState
extends State

@export
var speed: float = 200.0

var direction: float

func enter() -> void:
	player.sprite.modulate = Color8(255, 0, 0)
	player.velocity.y = 0

func process_phys(_delta: float) -> void:
	direction = Input.get_axis("left", "right")
	player.velocity.x = direction * speed

func process_state() -> State:
	if !direction:
		return player.states[0]
	if Input.is_action_just_pressed("jump"):
		return player.states[2]
	return null
