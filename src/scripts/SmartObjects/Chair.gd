extends SmartObject

func _init().():
	action_name = "*sitting*"
	action_length = 2.0

func interact(partner) -> Dictionary:
	partner.blackboard["energy"] += 1000
	return .interact(partner)

