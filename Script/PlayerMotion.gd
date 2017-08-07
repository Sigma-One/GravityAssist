extends Node2D


var speed = 200
var gravity = 5
var motionVector = Vector2(speed, 2)
var gravityFlipped = false
var screenSize = OS.get_window_size()
var mapPart = Array()
var mapPiece
var backgroundPiece
var timer
var mapPos = 0
var backgroundPos = 0
var mapHolder
var playerFront
var maps = Array()
var backgrounds = Array()
var HUD
var scoreCounterDelay = 0


func _ready():
	# Called every time the node is added to the scene.
	print("test!")
	set_fixed_process(true)
	set_process_input(true)
	mapHolder = get_node("mapHolder")
	playerFront = get_node("player/playerFront")
	maps.append("res://Maps/Map0.tscn")
	maps.append("res://Maps/Map1.tscn")
	maps.append("res://Maps/Map2.tscn")
	maps.append("res://Maps/MapTest.tscn")
	var mapStart = "res://Maps/MapTest.tscn"
	mapPiece = (load(mapStart).instance())


func _input(event):
	
	if Input.is_action_pressed("flipGravity") and gravityFlipped == true or event.type == InputEvent.SCREEN_TOUCH and gravityFlipped == true:
		motionVector.y = 0
		gravityFlipped = false;
		get_node("player/playerSprite").set_flip_v(false)
		get_node("player").set_gravity_scale(gravity)
		#motionVector = Vector2(speed, gravity)
	
	elif Input.is_action_pressed("flipGravity") and gravityFlipped == false or event.type == InputEvent.SCREEN_TOUCH and gravityFlipped == false:
		motionVector.y = 0
		gravityFlipped = true;
		get_node("player/playerSprite").set_flip_v(true)
		get_node("player").set_gravity_scale(-gravity)
		#motionVector = Vector2(speed, -gravity)

func _fixed_process(delta):
	global.playerPosition = get_node("player").get_pos()
	global.playerPosition += motionVector * delta
	
	
	get_node("player").set_pos(global.playerPosition)
	
	speed += 0.01
	#print(global.score)
	
	if playerFront.get_overlapping_bodies().size() > 1:
		death.death()
	
	######################################################
	
	
	backgrounds.append("res://Background/Background0.tscn")
	
	mapPiece.set_pos(Vector2(mapPos, 0))
	
	backgroundPiece = (load(backgrounds[randi() % backgrounds.size()]).instance())
	
	backgroundPiece.set_pos(Vector2(backgroundPos, 0))
	
	if mapPiece.get_pos().x < global.playerPosition.x + 800:
		mapHolder.add_child(mapPiece)
		mapPos += 64 * 4
		
	
	if backgroundPiece.get_pos().x < global.playerPosition.x + 800:
		mapHolder.add_child(backgroundPiece)
		backgroundPos += 128
	
	
	for i in range(mapHolder.get_child_count()):
		if(mapHolder.get_child(i).get_pos().x < global.playerPosition.x - 500):
			mapHolder.get_child(i).queue_free()
	
	mapPiece = (load(maps[randi() % maps.size()]).instance())
	
###########################################################################################################

	scoreCounterDelay += 1
	if scoreCounterDelay == 5:
		global.score +=1
		scoreCounterDelay = 0
