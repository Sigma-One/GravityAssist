extends Control


func _ready():
	set_fixed_process(true)
	print("test")
	get_node("CanvasLayer/GameOverScreen").set_pos(Vector2(OS.get_screen_size().x / 2 - get_node("CanvasLayer/GameOverScreen").get_size().x / 2, OS.get_screen_size().y / 2 - get_node("CanvasLayer/GameOverScreen").get_size().y))
	get_node("CanvasLayer/GameOverScreen/RestartButton").connect("pressed", self, "Restart")
	get_node("CanvasLayer/GameOverScreen/QuitButton").connect("pressed", self, "Quit")
	get_node("CanvasLayer/GameOverScreen/MenuButton").connect("pressed", self, "Menu")
	
func _fixed_process(delta):
	get_node("CanvasLayer/ScoreText").set_text("SCORE: " + str(global.score))
	get_node("CanvasLayer/GameOverScreen/ScoreText").set_text("SCORE: " + str(global.score))
	get_node("CanvasLayer/ScoreText").set_pos(Vector2(get_tree().get_root().get_visible_rect().size.x / 50, get_tree().get_root().get_visible_rect().size.y / 50))
	if not global.highScore == null and global.score > global.highScore or global.highScore == null:
			get_node("CanvasLayer/HighScoreText").set_text("HIGH: " + str(global.score))
			get_node("CanvasLayer/GameOverScreen/HighScoreText").set_text("HIGH: " + str(global.score))
	else:
		get_node("CanvasLayer/HighScoreText").set_text("HIGH: " + str(global.highScore))
		get_node("CanvasLayer/GameOverScreen/HighScoreText").set_text("HIGH: " + str(global.highScore))
	get_node("CanvasLayer/HighScoreText").set_pos(Vector2(get_node("CanvasLayer/ScoreText").get_pos().x, get_node("CanvasLayer/ScoreText").get_pos().y + 50))
	
	
func Restart():
	global.score = 0
	get_node("CanvasLayer/GameOverScreen").hide()
	get_tree().set_pause(false)
	get_tree().reload_current_scene()
	
func Quit():
	get_tree().quit()
	
func Menu():
	global.score = 0
	get_tree().change_scene("res://Scenes/MainMenu.tscn")