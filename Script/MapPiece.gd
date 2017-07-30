extends Node2D

var timer
var tilemap

func _ready():
	#print("ready2!")
	#timer = get_node("Timer")
	#timer.connect("timeout", self, "on_timer_timeout")
	tilemap = get_node("TileMap")

func on_timer_timeout():
	print("testing!")
	#tilemap.queue_free()