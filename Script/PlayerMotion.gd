extends Node2D

var speed = 150
var gravity = 5
var motionVector = Vector2(speed, gravity)
var gravityFlipped = false
var screenSize = OS.get_window_size()
var mapPart = Array()
var mapPiece
var timer
var mapPos = 0
var mapHolder
var playerFront
var maps = Array()

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".tscn"):
			files.append(file)
	
	dir.list_dir_end()

	return files


func _ready():
	# Called every time the node is added to the scene.
	set_fixed_process(true)
	set_process_input(true)
	mapHolder = get_node("Node2D")
	playerFront = get_node("player/playerFront")


func _input(flipGravity):
	
	if Input.is_action_pressed("flipGravity") and gravityFlipped == true:
		motionVector.y = 0
		gravityFlipped = false;
		get_node("player/playerSprite").set_flip_v(false)
		get_node("player").set_gravity_scale(gravity)
		#motionVector = Vector2(speed, gravity)
	
	elif Input.is_action_pressed("flipGravity") and gravityFlipped == false:
		motionVector.y = 0
		gravityFlipped = true;
		get_node("player/playerSprite").set_flip_v(true)
		get_node("player").set_gravity_scale(-gravity)
		#motionVector = Vector2(speed, -gravity)

func _fixed_process(delta):
	var playerPosition = get_node("player").get_pos()
	playerPosition += motionVector * delta
	
	
	get_node("player").set_pos(playerPosition)
	
	speed += 0.01
	
	if playerFront.get_overlapping_bodies().size() > 1:
		get_tree().reload_current_scene()
	
	######################################################
	
	var cameraPosition = get_node("player/camera").get_pos()
	
	maps.append("res://Maps/Map0.tscn")
	maps.append("res://Maps/Map1.tscn")
	maps.append("res://Maps/Map2.tscn")
	
	mapPiece = (load(maps[randi() % maps.size()]).instance())
	
	mapPiece.set_pos(Vector2(mapPos, 0))
	
	if mapPiece.get_pos().x < playerPosition.x + 800:
		mapHolder.add_child(mapPiece)
		mapPos += 64 * 4
	
	
	for i in range(mapHolder.get_child_count()):
		if(mapHolder.get_child(i).get_pos().x < playerPosition.x - 500):
			mapHolder.get_child(i).queue_free()
	
	