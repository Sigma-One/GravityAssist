extends Node

func death():
	if not global.highScore == null:
		if global.score > global.highScore:
			global.Save("game", "highScore", global.score)
	else:
		global.Save("game", "highScore", global.score)
	
	global.score = 0
	get_tree().reload_current_scene()
	
