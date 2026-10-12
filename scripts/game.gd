extends Node2D

func _on_tomacat_im_bored() -> void:
	print("Tomacat is bored")


func _on_tomacat_im_hungry() -> void:
	print("Tomacat is hungry")


func _on_tomacat_im_tired() -> void:
	print("Tomacat is tired")

func _on_tick() -> void:
	%Tomacat.on_tick()
	%Tick.start()
