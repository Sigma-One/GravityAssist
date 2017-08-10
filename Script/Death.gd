extends Node

func death():
	if not global.highScore == null:
		if global.score > global.highScore:
			global.Save("game", "highScore", global.score)
	else:
		global.Save("game", "highScore", global.score)
	
	get_tree().get_root().get_node("Node2D/player").hide()
	get_tree().get_root().get_node("Node2D/player/Control/CanvasLayer/GameOverScreen").show()
	get_tree().get_root().get_node("Node2D/player/Control/CanvasLayer/ScoreText").hide()
	get_tree().get_root().get_node("Node2D/player/Control/CanvasLayer/HighScoreText").hide()
	get_tree().set_pause(true)
	
