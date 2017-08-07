extends Node


func _ready():
	#set_fixed_process(true)
	print("testing once again")
	get_node("CanvasLayer/MainMenu").set_pos(Vector2(OS.get_screen_size().x / 2 - get_node("CanvasLayer/MainMenu").get_size().x / 2, OS.get_screen_size().y / 2))
	get_node("CanvasLayer/MainMenu/StartButton").connect("pressed", self, "Start")
	get_node("CanvasLayer/MainMenu/QuitButton").connect("pressed", self, "Quit")
	
	
	
func Start():
	#get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://Scenes/GamePlay.tscn")
	pass
func Quit():
	get_tree().quit()