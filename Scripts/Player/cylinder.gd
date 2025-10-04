class_name Cylinder
extends Control

var current_queue: PackedStringArray = []

@export
var queue_length: int = 1

func _process(delta: float) -> void:
	global_position = Vector2.ZERO

func cast() -> void:
	if !current_queue.is_empty():
		var spell: String = current_queue[0]
		current_queue.remove_at(0)

		print(spell)
		print(current_queue)

func add_to_queue(spell: String) -> void:
	if current_queue.size() < queue_length:
		current_queue.append(spell)
	

func empty_queue() -> void:
	current_queue.clear()

func grow_queue():
	queue_length += 1
