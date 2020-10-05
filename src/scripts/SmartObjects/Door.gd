extends SmartObject

export (NodePath) var door_object
var opened = false
var knocked = false

func _init().():
	action_name = "*answering*"
	action_length = 0.5

func interact(partner) -> Dictionary:
	opened = true
	knocked = false
	get_node(door_object).visible = false
	$"3DText".text = ""
	return .interact(partner)

func knock():
	knocked = true
	$"3DText".text = "*knocking*"
