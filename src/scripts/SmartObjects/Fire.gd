extends SmartObject

export (NodePath) var fire_object

var lit = false

func _init().():
	action_name = "*putting out fire*"
	action_length = 0.1

func interact(partner) -> Dictionary:
	get_node(fire_object).visible = false
	partner.blackboard.fire = null
	return .interact(partner)

func start_fire():
	lit = true
	get_node(fire_object).visible = true
