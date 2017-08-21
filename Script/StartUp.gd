extends Node

#Runs on startup and loads maps and stuff.

func _ready():
	
	#Load maps
	global.maps = LoadFiles("res://Maps/", "scn")
	global.maps += LoadFiles("user://Mods/Maps/", "scn")
	global.maps += LoadFiles("res://Maps/", "tscn")
	global.maps += LoadFiles("user://Mods/Maps/", "tscn")
	print(global.maps)
	
	#Load backgrounds
	global.backgrounds = LoadFiles("res://Backgrounds/", "scn")
	global.backgrounds += LoadFiles("user://Mods/Backgrounds/", "scn")
	global.backgrounds += LoadFiles("res://Backgrounds/", "tscn")
	global.backgrounds += LoadFiles("user://Mods/Backgrounds/", "tscn")
	print(global.backgrounds)
	
	#Load ships
	global.ships = LoadFiles("res://Ships/", "tres")
	global.ships += LoadFiles("user://Mods/Ships/", "tres")
	print(global.ships)
	
	#Make sure a ship is selected
	if not global.Load("game", "ship") == null:
		global.selectedShip = global.ships[global.Load("game", "ship")]
	else:
		global.selectedShip = global.ships[0]

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