extends SmartObject

func _init().():
	action_name = "*looting*"
	action_length = 1.0

func interact(partner) -> Dictionary:
	partner.blackboard["has_loot"] = true
	return .interact(partner)
