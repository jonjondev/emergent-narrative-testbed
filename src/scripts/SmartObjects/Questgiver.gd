extends SmartObject

func _init().():
	action_name = "*quest-taking*"
	action_length = 1.0

func interact(partner) -> Dictionary:
	partner.blackboard["quest"] = get_tree().get_nodes_in_group("treasure")[0].translation
	return .interact(partner)
