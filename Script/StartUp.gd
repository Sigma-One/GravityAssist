extends Node

#Runs on startup and loads maps and stuff.

func _ready():
	
	global.maps = LoadFiles("res://Maps/", "scn")
	#global.backgrounds += LoadFiles("user://Mods/Maps/", "tscn")
	print(global.maps)
	
	global.backgrounds = LoadFiles("res://Background/", "scn")
	#global.backgrounds += LoadFiles("user://Mods/Backgrounds/", "tscn")
	print(global.backgrounds)

	global.ships = LoadFiles("res://Texture/Player/", "tres")
	#global.ships += LoadFiles("user://Mods/Ships/", "tres")
	if not global.Load("game", "ship") == null:
		global.selectedShip = global.ships[global.Load("game", "ship")]
	else:
		global.selectedShip = global.ships[0]
	print(global.ships)

func LoadFiles(path, extension):
	var toLoad = []
	var loaded = []
	var directory = Directory.new()
	
	directory.open(path)
	directory.list_dir_begin()
	
	while true:
		var file = directory.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.extension() == extension:
			toLoad.append(file)
	
	directory.list_dir_end()
	
	for i in toLoad:
		print(i)
		var file = load(path + str(i))
		loaded.append(file)
		
	return loaded