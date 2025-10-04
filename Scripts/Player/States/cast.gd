class_name PlayerCastState
extends State

var spell: SpellCast
var release: bool = false

func _ready() -> void:
	super()
	spell = player.get_node("Spellcast")

func enter() -> void:
	player.sprite.modulate = Color8(0, 0, 255)
	spell.visible = true

func exit() -> void:
	spell.visible = false

func process_frame(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		release = true

func process_state() -> State:
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and release:
		release = false
		spell.cast()
		return player.states[0]
	if Input.is_action_just_pressed("ui_cancel"):
		release = false
		return player.states[0]
	return null
