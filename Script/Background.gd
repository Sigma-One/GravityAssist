extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	set_pos(Vector2(get_pos().x, global.playerPosition.y * 0.5)) 