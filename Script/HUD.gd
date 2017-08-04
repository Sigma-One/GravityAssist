extends Control

var scoreCounterDelay = 0

func _ready():
	set_fixed_process(true)
	print("test")
	
func _fixed_process(delta):
	get_node("CanvasLayer/ScoreText").set_text("SCORE: " + str(global.score))
	get_node("CanvasLayer/ScoreText").set_pos(Vector2(get_tree().get_root().get_visible_rect().size.x / 50, get_tree().get_root().get_visible_rect().size.y / 50))
	get_node("CanvasLayer/HighScoreText").set_text("HIGH: " + str(global.highScore))
	get_node("CanvasLayer/HighScoreText").set_pos(Vector2(get_node("CanvasLayer/ScoreText").get_pos().x, get_node("CanvasLayer/ScoreText").get_pos().y + 50))
	
	scoreCounterDelay += 1
	if scoreCounterDelay == 5:
		global.score +=1
		scoreCounterDelay = 0