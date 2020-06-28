extends SmartObject

func _init().():
	action_name = "*sitting*"
	action_length = 2.0

func interact(partner) -> Dictionary:
	partner.blackboard["energy"] += 500
	return {
		"name": action_name,
		"length": action_length,
	}

