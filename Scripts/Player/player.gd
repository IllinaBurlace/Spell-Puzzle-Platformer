class_name Player
extends CharacterBody2D

var states: Array[State]

@onready
var current_state: State = $States/Idle
@onready
var sprite: Polygon2D = $Polygon2D

func _ready() -> void:
	for node in $States.get_children():
		states.append(node)
	
	current_state.enter()

func _process(delta: float) -> void:
	current_state.process_frame(delta)
	state_machine()

func _physics_process(delta: float) -> void:
	current_state.process_phys(delta)

func state_machine() -> void:
	var new_state = current_state.process_state()
	if new_state:
		current_state.exit()
		current_state = new_state
		current_state.enter()
