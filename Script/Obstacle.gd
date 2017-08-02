func _ready():
	set_process(true)
	
func _process(delta):
	if get_node("CollisionArea").get_overlapping_bodies().size() > 1:
		#OS.delay_msec(1000)
		death.death()
