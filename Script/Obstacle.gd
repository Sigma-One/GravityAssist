#Ran when an obstacle detects collision. I think.

func _ready():
	set_process(true)
	
func _process(delta):
	if get_node("CollisionArea").get_overlapping_bodies().size() > 1:
		death.death()