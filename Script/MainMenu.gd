extends Node

#Main menu

func _ready():
	print("testing once again")
	
	#Unpause for good measure.
	get_tree().set_pause(false)
	
	#Set UI position
	get_node("CanvasLayer/MainMenu").set_pos(Vector2(OS.get_screen_size().x / 2 - get_node("CanvasLayer/MainMenu").get_size().x / 2, OS.get_screen_size().y / 2 - get_node("CanvasLayer/MainMenu").get_size().y * 2))
	
	#Connect buttons to functions.
	get_node("CanvasLayer/MainMenu/StartButton").connect("pressed", self, "Start")
	get_node("CanvasLayer/MainMenu/ShipSelectorButton").connect("pressed", self, "ShipSelect")
	get_node("CanvasLayer/MainMenu/QuitButton").connect("pressed", self, "Quit")
	
#Ran when start is pressed.
func Start():
	get_tree().change_scene("res://Scenes/GamePlay.tscn")

#Ran when ship select is pressed.
func ShipSelect():
	get_tree().change_scene("res://Scenes/ShipSelector.tscn")

#Ran when quit is pressed.
func Quit():
	get_tree().quit()