class_name SpellCast
extends Control

@export
var epsilon: float = 30.0
@onready
var player: Player = get_parent()
@onready 
var line: Line2D = $Glyph

func _process(delta: float) -> void:
	global_position = Vector2.ZERO

	if visible:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			line.add_point(get_viewport().get_mouse_position())
func cast() -> void:
	print("Cast!")
	var simple = simplify(line.get_points())
	print(simple)
	line.clear_points()

func simplify(input: PackedVector2Array) -> PackedVector2Array:
	var curve: Curve2D = Curve2D.new()
	curve.add_point(input[0])
	curve.add_point(input[-1])
	
	var highest: Dictionary = {"id": 0, "dist": 0.0}
	var current: int = 0
	for point in input:
		if current > 0:
			var offset: float = curve.get_closest_offset(point)
			var pos: Vector2 = curve.sample_baked(offset)
			if pos.distance_to(point) > highest["dist"]:
				highest["id"] = current
				highest["dist"] = pos.distance_to(point)
		current += 1
	
	var ret: PackedVector2Array = []
	if highest["dist"] > epsilon:
		ret = simplify(input.slice(0, highest["id"] + 1))
		var temp: PackedVector2Array = simplify(input.slice(highest["id"] + 1, -1))
		temp.remove_at(0)
		ret.append_array(temp)
	else:
		ret = [input[0], input[-1]]

	return ret
