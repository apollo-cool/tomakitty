extends Node2D
class_name Game

@export var ball_position := Vector2(29,43)
@export var bed_position: Vector2
@export var food_position: Vector2

@export var ball_resource: PackedScene
@export var bed_resource: PackedScene
@export var food_resource: PackedScene

@onready var tomacat: Tomacat = %Tomacat
@onready var tick: Timer = %Tick

func _on_player_played(ball: Ball) -> void:
	ball.queue_free()
	tomacat.play_game()

func _on_slept(bed: Bed) -> void:
	bed.queue_free()
	tomacat.bedtime()

func _on_tomacat_im_bored() -> void:
	var ball: Ball = ball_resource.instantiate()
	add_child(ball)
	ball.position = ball_position
	ball.done_playing.connect(_on_player_played)

func _on_tomacat_im_hungry() -> void:
	print("Tomacat is hungry")

func _on_tomacat_im_tired() -> void:
	var bed: Bed = bed_resource.instantiate()
	add_child(bed)
	bed.position = bed_position
	bed.tomakitty_slept.connect(_on_slept)

func _on_tick() -> void:
	tomacat.on_tick()
