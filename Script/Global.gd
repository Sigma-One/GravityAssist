extends Node

#Holds some global variables and functions.

var playerPosition
var cameraPosition
var score = 0
var saveFile = ConfigFile.new()
var savePath = "user://save.cfg"
var highScore
var ships = []
var maps
var backgrounds
var selectedShip


#Saves the supplied data to the section and entry provided
func Save(section, entry, data):
	saveFile.set_value(section, entry, data)
	var saveResult = saveFile.save(savePath)
	print(saveResult)
	
	#Ran if saving fails.
	if saveResult != 0:
		print("Saving failed")

#Loads data from the provided section and entry.
func Load(section, entry):
	if saveFile.load(savePath) == 0:
		var data = saveFile.get_value(section, entry)
		return data

#Just constantly loads the high score. Temp thingy.
func _process(delta):
	highScore = Load("game", "highScore")
	
#Ran when the file is loaded.
func _ready():
	print("testing again")
	
	
	set_process(true)