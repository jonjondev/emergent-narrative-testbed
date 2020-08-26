extends SmartObject

func _init().():
	action_name = "*sleeping*"
	action_length = 3.0

func interact(partner) -> Dictionary:
	partner.blackboard["energy"] += 1000
	return .interact(partner)

