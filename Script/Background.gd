extends Node2D

#Simple script that adjusts the background position in relation to the player's position.

func _ready():
	set_process(true)

func _process(delta):
	set_pos(Vector2(get_pos().x, global.playerPosition.y * 0.5)) 