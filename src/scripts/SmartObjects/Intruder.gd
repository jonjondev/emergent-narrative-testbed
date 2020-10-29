extends SmartObject

export (NodePath) var intruder_object

var present = false

func _init().():
	action_name = "*shooting*"
	action_length = 0.1

func interact(partner) -> Dictionary:
	get_node(intruder_object).visible = false
	present = false
	partner.blackboard.intruder = null
	partner.blackboard.has_gun = null
	return .interact(partner)

func intrude():
	present = true
	get_node(intruder_object).visible = true
