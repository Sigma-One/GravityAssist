extends Node

func death():
	global.score = 0
	get_tree().reload_current_scene()