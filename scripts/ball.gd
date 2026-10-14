extends Node2D
class_name Ball
signal done_playing(ball: Ball)

func _on_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		done_playing.emit(self)
