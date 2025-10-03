class_name PlayerCastState
extends State

var spell: SpellCast

func _ready() -> void:
	super()
	spell = player.get_node("Spellcast")

func enter() -> void:
	player.sprite.modulate = Color8(0, 0, 255)
	spell.visible = true

func exit() -> void:
	spell.visible = false
	spell.cast()

func process_state() -> State:
	if Input.is_action_just_pressed("cast"):
		return player.states[0]
	return null
