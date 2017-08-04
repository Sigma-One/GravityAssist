extends Node

var playerPosition
var cameraPosition
var score = 0
var saveFile = ConfigFile.new()
var savePath = "user://save.cfg"
var highScore

func Save(section, entry, data):
	saveFile.set_value(section, entry, data)
	var saveResult = saveFile.save(savePath)
	print(saveResult)
	if saveResult != 0:
		print("Saving failed")
	
func Load(section, entry):
	if saveFile.load(savePath) == 0:
		var data = saveFile.get_value(section, entry)
		return data
		
func _process(delta):
	highScore = Load("game", "highScore")
	
func _ready():
	set_process(true)