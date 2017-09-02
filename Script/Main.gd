extends Node2D

#Main gameplay script.

var speed = 150
var gravity = 5
var gravityFlipped = false
var timer
var playerFront
var HUD
var scoreCounterDelay = 0
var mapPiece
var backgroundPiece
var mapHolder
var mapPos = 0
var backgroundPos = 0
var startMaps = 0

#Initialization stuff mostly.
func _ready():
	print("test!")
	set_fixed_process(true)
	set_process_input(true)
	
	#Set map and background instance parent.
	mapHolder = get_node("mapHolder")
	
	#Set player front collider for collision management
	playerFront = get_node("player/playerFront")
	
	
	print(global.selectedShip)
	
	#Set player spriteFrames to selected ship.
	get_node("player/playerSprite").set_sprite_frames(global.selectedShip)
	
	get_node("player").set_pos(Vector2(get_node("player").get_pos().x + 200, 0))
	
#Input handling.
func _input(event):

	#Ran if gravity is not flipped.
	if Input.is_action_pressed("flipGravity") and gravityFlipped == true or event.type == InputEvent.SCREEN_TOUCH and gravityFlipped == true:
		gravityFlipped = false;
		get_node("player/playerSprite").set_flip_v(false)
		get_node("player").set_gravity_scale(gravity)
	
	#Ran if gravity is flipped.
	elif Input.is_action_pressed("flipGravity") and gravityFlipped == false or event.type == InputEvent.SCREEN_TOUCH and gravityFlipped == false:
		gravityFlipped = true;
		get_node("player/playerSprite").set_flip_v(true)
		get_node("player").set_gravity_scale(-gravity)
	
	if Input.is_action_pressed("pause"):
		get_node("player/Control").Pause()

#Stuff happening every tick.
func _fixed_process(delta):
	
	#Set global player position variable.
	global.playerPosition = get_node("player").get_pos()
	
	#Move player forwards.
	global.playerPosition += Vector2(speed, 0) * delta
	get_node("player").set_pos(global.playerPosition)
	
	#Slowly increase player speed
	speed += 0.01
	
	#Kill player if front collider hits anything.
	if playerFront.get_overlapping_bodies().size() > 1:
		death.death()
	
	backgroundPiece = global.backgrounds[randi() % global.backgrounds.size()].instance()
	
	backgroundPiece.set_pos(Vector2(backgroundPos, 0))
	
	if startMaps <= 2:
		mapPiece = global.maps[0].instance()
		startMaps += 1
	
	else:
		mapPiece = global.maps[randi() % global.maps.size()].instance()
	
	mapPiece.set_pos(Vector2(mapPos, 0))
	
	if mapPiece.get_pos().x < global.playerPosition.x + 800:
		mapHolder.add_child(mapPiece)
		mapPos += 64 * 4
		
	
	if backgroundPiece.get_pos().x < global.playerPosition.x + 800:
		mapHolder.add_child(backgroundPiece)
		backgroundPos += 128
	
	
	for i in range(mapHolder.get_child_count()):
		if(mapHolder.get_child(i).get_pos().x < global.playerPosition.x - 500):
			mapHolder.get_child(i).queue_free()
	
	
	#Increment score.
	scoreCounterDelay += 1
	if scoreCounterDelay == 5:
		global.score +=1
		scoreCounterDelay = 0
