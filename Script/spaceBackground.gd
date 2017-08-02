extends Polygon2D


func _ready():
	set_process(true)
	
func _process(delta):
	set_texture_offset(Vector2(0, -global.playerPosition.y))
	set_pos(Vector2(global.playerPosition.x, 0))
