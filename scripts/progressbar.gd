extends Node2D

# Reference your UI nodes at the top of your script
@onready var label: Label = %Label
@onready var progress_bar: ProgressBar = %ProgressBar

var current_value: float = 0

func set_label(text: String) -> void:
	label.text = text

func set_value(value: float) -> void:
	current_value = value
	progress_bar.value = value
