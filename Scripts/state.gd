@abstract
class_name State
extends Node

var player: Player

func _ready() -> void:
	player = get_parent().get_parent()

func process_frame(_delta: float) -> void:
	pass

func process_phys(_delta: float) -> void:
	pass

func process_state() -> State:
	return null

func enter() -> void:
	pass

func exit() -> void:
	pass
