extends SmartObject

export (NodePath) var gun_object

func _init().():
	action_name = "*picking up gun*"
	action_length = 0.1

func interact(partner) -> Dictionary:
	get_node(gun_object).visible = false
	partner.blackboard.gun = null
	partner.blackboard["has_gun"] = true
	queue_free()
	return .interact(partner)
