extends Control

#Ship selector. My code seems to get messier the newer it is.

#Default selection.
var selection

func _ready():
	if not global.Load("game", "ship") == null:
		selection = global.Load("game", "ship")
	else:
		selection = 0
	#Position stuff.
	get_node("CanvasLayer/Ship").set_pos(Vector2(OS.get_screen_size().x / 2, OS.get_screen_size().y / 2))
	get_node("CanvasLayer/Right").set_pos(Vector2(OS.get_screen_size().x / 1.5, OS.get_screen_size().y / 2 - get_node("CanvasLayer/Right").get_size().y / 2))
	get_node("CanvasLayer/Left").set_pos(Vector2(OS.get_screen_size().x / 3.5, OS.get_screen_size().y / 2 - get_node("CanvasLayer/Left").get_size().y / 2))
	get_node("CanvasLayer/Back").set_pos(Vector2(OS.get_screen_size().x / 2 - get_node("CanvasLayer/Back").get_size().x / 2, OS.get_screen_size().y / 1.3))
	
	
	
	get_node("CanvasLayer/Right").connect("pressed", self, "NextShip")
	get_node("CanvasLayer/Left").connect("pressed", self, "PrevShip")
	get_node("CanvasLayer/Back").connect("pressed", self, "Back")
	
	
	set_process(true)
	
func _process(delta):
	
	get_node("CanvasLayer/Ship").set_sprite_frames(global.ships[selection])
	get_node("CanvasLayer/Ship").play()
	global.selectedShip = global.ships[selection]
	print(get_node("CanvasLayer/Ship").is_playing())
	print(global.selectedShip)
	
func NextShip():
	if selection < global.ships.size() - 1:
		selection += 1
	print(selection)

func PrevShip():
	if selection > 0:
		selection -= 1
	print(selection)
	
func Back():
	global.Save("game", "ship", selection)
	get_tree().change_scene("res://Scenes/MainMenu.tscn")