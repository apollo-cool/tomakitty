extends AnimatedSprite2D

@export var hunger := 10 
@export var boredom := 10 
@export var tiredness := 10	

signal im_hungry
signal im_bored
signal im_tired

func _hunger_tick() -> void:
	if (hunger <= 0):
		return 

	var random := randi_range(1,10)
	
	if (random == 1):
		hunger -= 1
		
	if (hunger <= 0):
		im_hungry.emit()

func _boredom_tick() -> void:
	if (boredom <= 0):
		return 

	var random := randi_range(1,10)
	
	if (random == 1):
		boredom -= 1
		
	if (boredom <= 0):
		im_bored.emit()
		
func _tiredness_tick() -> void:
	if (boredom <= 0):
		return 

	var random := randi_range(1,10)
	
	if (random == 1):
		boredom -= 1
		
	if (tiredness <= 0):
		im_tired.emit()

## This function allows you to play with Tomacat
## Puts his boredom stat at max
func play_game() -> void:
	boredom = 10

## This function feeds Tomacat
## Puts hunger stat at max
func feed() -> void:
	hunger = 10
	
	
## This function puts Tomacat to sleep.
## Puts tiredness stat at max
func bedtime() -> void:
	tiredness = 10

func on_tick() -> void:
	_hunger_tick()
	_boredom_tick()
	_tiredness_tick()
	
	print("Hunger: " + str(hunger))
	print("Boredom: " + str(boredom))
	print("Tiredness: " + str(tiredness))
	
