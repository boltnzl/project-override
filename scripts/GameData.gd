extends Node

var puzzle_open: bool = false
var current_level: int = 1
var unlockedlevel: int = 1

var current_mag: int = 25
var total_ammo: int = 100
var max_mag: int = 25

const SAVE_PATH: String = "user://game_data.save"


func _ready():
	load_data()

# Saves the player's unlocked level, current magazine, and total ammo to a separate file
func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(unlockedlevel)
		file.store_var(current_mag)
		file.store_var(total_ammo)
		file.close()

# Loads the player's unlocked level, current magazine, and total ammo from file 
func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			unlockedlevel = file.get_var()
			current_mag = file.get_var()
			total_ammo = file.get_var()
			file.close()

# Resets the unlocked level, current magazine, and total ammo values and deletes save file
func reset_data():
	unlockedlevel = 1
	current_mag = max_mag
	total_ammo = 100
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))
