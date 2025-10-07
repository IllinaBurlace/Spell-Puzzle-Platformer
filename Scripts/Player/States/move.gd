class_name PlayerMoveState
extends State

@export
var speed: float = 200.0

var direction: float

func enter() -> void:
	player.sprite.modulate = Color8(255, 0, 0)
	player.velocity.y = 0

func process_frame(_delta: float) -> void:
	if Input.is_action_just_pressed("spell"):
		player.cylinder.cast()

func process_phys(_delta: float) -> void:
	direction = Input.get_axis("left", "right")
	player.velocity.x = direction * speed

	for col_count in player.get_slide_collision_count():
		var col = player.get_slide_collision(col_count)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_central_force(col.get_normal() * -2500)

func process_state() -> State:
	if !direction:
		return player.states[0]
	if Input.is_action_just_pressed("jump"):
		return player.states[2]
	return null
