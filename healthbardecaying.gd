extends Node

# UI Reference
@onready var health_bar: TextureProgressBar = $HealthBar

# Game Settings
const MAX_HEALTH: float = 100.0
const DECAY_INTERVAL_SECONDS: float = 600.0 # 10 minutes = 600 seconds
const DECAY_AMOUNT: float = 10.0 # How much health drops every 10 minutes

# Pet Stats
var current_health: float = MAX_HEALTH
var last_interacted_time: int = 0

func _ready() -> void:
	# Initialize last interaction time to current time on first boot
	last_interacted_time = Time.get_unix_time_from_system()
	
	# Load any previously saved data
	load_game()
	
	# Calculate offline deterioration right away
	apply_offline_decay()
	update_ui()

func _process(_delta: float) -> void:
	# Continuously check for real-time deterioration while playing
	var current_time: int = Time.get_unix_time_from_system()
	var seconds_passed: float = current_time - last_interacted_time
	
	if seconds_passed >= DECAY_INTERVAL_SECONDS:
		# Calculate how many 10-minute blocks passed
		var intervals_passed: int = floor(seconds_passed / DECAY_INTERVAL_SECONDS)
		
		# Deduct health
		current_health -= intervals_passed * DECAY_AMOUNT
		current_health = clamp(current_health, 0.0, MAX_HEALTH)
		
		# Move the timer forward by the chunks we just consumed
		last_interacted_time += intervals_passed * int(DECAY_INTERVAL_SECONDS)
		
		update_ui()
		save_game()

# Call this when the player feeds the pet
func feed_pet(amount: float = 20.0) -> void:
	reset_decay_timer()
	current_health += amount
	current_health = clamp(current_health, 0.0, MAX_HEALTH)
	update_ui()
	save_game()
	print("Pet fed! Health is now: ", current_health)

# Call this when the player plays with the pet
func play_with_pet(amount: float = 15.0) -> void:
	reset_decay_timer()
	current_health += amount
	current_health = clamp(current_health, 0.0, MAX_HEALTH)
	update_ui()
	save_game()
	print("Played with pet! Health is now: ", current_health)

# Resets the 10-minute window because attention was given
func reset_decay_timer() -> void:
	last_interacted_time = Time.get_unix_time_from_system()

# Calculates how much health was lost while the game was closed
func apply_offline_decay() -> void:
	var current_time: int = Time.get_unix_time_from_system()
	var seconds_passed: float = current_time - last_interacted_time
	
	if seconds_passed >= DECAY_INTERVAL_SECONDS:
		var intervals_passed: int = floor(seconds_passed / DECAY_INTERVAL_SECONDS)
		current_health -= intervals_passed * DECAY_AMOUNT
		current_health = clamp(current_health, 0.0, MAX_HEALTH)
		
		# Update the anchor time to account for the lost chunks
		last_interacted_time += intervals_passed * int(DECAY_INTERVAL_SECONDS)

func update_ui() -> void:
	if health_bar:
		health_bar.max_value = MAX_HEALTH
		health_bar.value = current_health

# --- Local Save System ---
func save_game() -> void:
	var save_data := {
		"current_health": current_health,
		"last_interacted_time": last_interacted_time
	}
	var file := FileAccess.open("user://pet_save.dat", FileAccess.WRITE)
	if file:
		file.store_var(save_data)

func load_game() -> void:
	if FileAccess.file_exists("user://pet_save.dat"):
		var file := FileAccess.open("user://pet_save.dat", FileAccess.READ)
		if file:
			var save_data = file.get_var()
			if save_data is Dictionary:
				current_health = save_data.get("current_health", MAX_HEALTH)
				last_interacted_time = save_data.get("last_interacted_time", Time.get_unix_time_from_system()
