extends Node2D

class_name Bed
signal tomakitty_slept

func _on_area_2d_input_event(_viewport: Node, event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		tomakitty_slept.emit()
