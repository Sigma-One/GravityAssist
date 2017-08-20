extends Node

#Handles deaths

func death():
	#If global var highScore is not NULL, save the current score if it is higher than the old highScore.
	if not global.highScore == null:
		if global.score > global.highScore:
			global.Save("game", "highScore", global.score)
	
	#Ran if highScore is NULL. Just saves the current score.
	else:
		global.Save("game", "highScore", global.score)
	
	#Show the game over screen.
	get_tree().get_root().get_node("Node2D/player").hide()
	get_tree().get_root().get_node("Node2D/player/Control/CanvasLayer/GameOverScreen").show()
	get_tree().get_root().get_node("Node2D/player/Control/CanvasLayer/ScoreText").hide()
	get_tree().get_root().get_node("Node2D/player/Control/CanvasLayer/HighScoreText").hide()
	get_tree().set_pause(true)
	
