extends Node2D
class_name Game

@export var ball_position := Vector2(29,43)
@export var bed_position: Vector2
@export var food_position: Vector2

@export var ball_resource: PackedScene
@onready var tomacat: Tomacat = %Tomacat
@onready var tick: Timer = %Tick

func _on_player_played(ball: Ball) -> void:
	ball.queue_free()
	tomacat.play_game()

func _on_tomacat_im_bored() -> void:
	var ball: Ball = ball_resource.instantiate()
	add_child(ball)
	ball.position = ball_position
	ball.done_playing.connect(_on_player_played)

func _on_tomacat_im_hungry() -> void:
	print("Tomacat is hungry")


func _on_tomacat_im_tired() -> void:
	print("Tomacat is tired")

func _on_tick() -> void:
	tomacat.on_tick()


func _on_tick_timeout() -> void:
	pass # Replace with function body.
