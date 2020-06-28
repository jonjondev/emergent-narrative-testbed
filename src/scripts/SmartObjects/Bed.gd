extends SmartObject

func _init().():
	action_name = "*sleeping*"
	action_length = 5.0

func interact(partner) -> Dictionary:
	partner.blackboard["energy"] += 1000
	return {
		"name": action_name,
		"length": action_length,
	}

