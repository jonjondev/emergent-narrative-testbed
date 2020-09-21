extends SmartObject

func _init().():
	action_name = "*eating*"
	action_length = 2.0

func interact(partner) -> Dictionary:
	get_tree().get_nodes_in_group("door")[0].knock()
	partner.blackboard["hunger"] += 1000
	return .interact(partner)
