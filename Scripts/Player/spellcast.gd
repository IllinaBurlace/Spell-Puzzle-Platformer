class_name SpellCast
extends Control

@export
var epsilon: float = 30.0
@onready
var player: Player = get_parent()
@onready 
var line: Line2D = $Glyph

@onready
var spells: Array = preload("res://Scripts/spells.json").data

func _process(delta: float) -> void:
	global_position = Vector2.ZERO

	if visible:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			line.add_point(get_viewport().get_mouse_position())
func cast() -> void:
	print("Cast!")
	var simple = simplify(line.get_points())
	var angles = curve_to_anglesig(simple)
	var spell = anglesig_match(angles)
	print(spell)
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

func curve_to_anglesig(input: PackedVector2Array) -> PackedFloat64Array:
	var ret: PackedFloat64Array = []
	
	var idx: int = 0
	for point in input:
		var unsnapped_angle: float = 0.0
		var snapped_angle: float = 0.0
		if idx < input.size() - 1:
			unsnapped_angle = point.angle_to_point(input[idx + 1])
			snapped_angle = snappedf(unsnapped_angle, PI/4)
		elif idx == input.size() - 1:
			unsnapped_angle = point.angle_to_point(input[0])
			snapped_angle = snappedf(unsnapped_angle, PI/4)
		if rad_to_deg(snapped_angle == -180.0):
			ret.append(180.0)
		else:
			ret.append(rad_to_deg(snapped_angle))
		idx += 1
	
	return ret

func anglesig_match(input: PackedFloat64Array) -> String:
	for spell in spells:
		var angles: PackedFloat64Array = spell["Angles"]
		if angles == input:
			return spell["Name"]
	
	return "Incorrect"
