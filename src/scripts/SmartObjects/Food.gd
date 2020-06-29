extends SmartObject

func _init().():
	action_name = "*eating*"
	action_length = 2.0

func interact(partner) -> Dictionary:
	partner.blackboard["hunger"] += 1500
	return .interact(partner)
