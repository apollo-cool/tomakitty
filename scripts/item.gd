extends Node2D

signal action_completed

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		action_completed.emit()
