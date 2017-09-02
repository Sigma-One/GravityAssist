extends Control
#Script for the in-game HUD.

#Ran when file is loaded.
func _ready():
	set_fixed_process(true)
	print("test")
	
	#Set game over screen position.
	get_node("CanvasLayer/GameOverScreen").set_pos(Vector2(OS.get_screen_size().x / 2 - get_node("CanvasLayer/GameOverScreen").get_size().x / 2, OS.get_screen_size().y / 2 - get_node("CanvasLayer/GameOverScreen").get_size().y))
	
	#Set pause screen position.
	get_node("CanvasLayer/PauseScreen").set_pos(Vector2(OS.get_screen_size().x / 2 - get_node("CanvasLayer/PauseScreen").get_size().x / 2, OS.get_screen_size().y / 2 - get_node("CanvasLayer/PauseScreen").get_size().y))
	
	#Connect all game over screen buttons to functions.
	get_node("CanvasLayer/GameOverScreen/RestartButton").connect("pressed", self, "Restart")
	get_node("CanvasLayer/GameOverScreen/QuitButton").connect("pressed", self, "Quit")
	get_node("CanvasLayer/GameOverScreen/MenuButton").connect("pressed", self, "Menu")

	#Connect all pause screen buttons to functions.
	get_node("CanvasLayer/PauseScreen/ResumeButton").connect("pressed", self, "Resume")
	get_node("CanvasLayer/PauseScreen/QuitButton").connect("pressed", self, "Quit")
	get_node("CanvasLayer/PauseScreen/MenuButton").connect("pressed", self, "Menu")
	
	#Connect pause button to pause
	get_node("CanvasLayer/PauseButton").connect("pressed", self, "Pause")
	get_node("CanvasLayer/PauseButton").set_pos(Vector2(get_tree().get_root().get_visible_rect().size.x - get_node("CanvasLayer/PauseButton").get_size().x * 2, get_tree().get_root().get_visible_rect().size.y / 50))
	
#Stuff that is ran every tick.
func _fixed_process(delta):
	
	#Set score text.
	get_node("CanvasLayer/ScoreText").set_text("SCORE: " + str(global.score))
	get_node("CanvasLayer/GameOverScreen/ScorePart/ScoreText").set_text("SCORE: " + str(global.score))
	get_node("CanvasLayer/PauseScreen/ScorePart/ScoreText").set_text("SCORE: " + str(global.score))
	
	#If high score is beaten, set current score as high score.
	if not global.highScore == null and global.score > global.highScore or global.highScore == null:
			get_node("CanvasLayer/HighScoreText").set_text("HIGH: " + str(global.score))
			get_node("CanvasLayer/GameOverScreen/ScorePart/HighScoreText").set_text("HIGH: " + str(global.score))
			get_node("CanvasLayer/PauseScreen/ScorePart/HighScoreText").set_text("HIGH: " + str(global.score))
	
	#If high score isn't beaten, set text to previous high score.
	else:
		get_node("CanvasLayer/HighScoreText").set_text("HIGH: " + str(global.highScore))
		get_node("CanvasLayer/GameOverScreen/ScorePart/HighScoreText").set_text("HIGH: " + str(global.highScore))
		get_node("CanvasLayer/PauseScreen/ScorePart/HighScoreText").set_text("HIGH: " + str(global.highScore))
	
	#Set position of score texts.
	get_node("CanvasLayer/ScoreText").set_pos(Vector2(get_tree().get_root().get_visible_rect().size.x / 50, get_tree().get_root().get_visible_rect().size.y / 50))
	get_node("CanvasLayer/HighScoreText").set_pos(Vector2(get_node("CanvasLayer/ScoreText").get_pos().x, get_node("CanvasLayer/ScoreText").get_pos().y + 50))

#Ran if restart is pressed.
func Restart():
	
	#Reset last score.
	global.score = 0
	
	#Hide game over screen.
	get_node("CanvasLayer/GameOverScreen").hide()
	
	#Unpause.
	get_tree().set_pause(false)
	
	#Reload Scene.
	get_tree().reload_current_scene()

func Resume():
	get_tree().set_pause(false)
	get_node("CanvasLayer/PauseScreen").hide()
	get_node("CanvasLayer/ScoreText").show()
	get_node("CanvasLayer/HighScoreText").show()

#Ran if quit is pressed.
func Quit():
	
	#Quit game.
	get_tree().quit()

#Ran if menu is pressed.
func Menu():
	
	#Reset current score, just for good measure.
	global.score = 0
	
	#Change to main menu scene.
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func Pause():
	if not get_tree().is_paused():
		get_node("CanvasLayer/ScoreText").hide()
		get_node("CanvasLayer/HighScoreText").hide()
		get_tree().set_pause(true)
		get_node("CanvasLayer/PauseScreen").show()