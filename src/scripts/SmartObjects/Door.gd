extends SmartObject

var opened = false
var knocked = false

func _init().():
	action_name = "*answering*"
	action_length = 2.0

func interact(partner) -> Dictionary:
	opened = true
	knocked = false
	$"3DText".text = ""
	return .interact(partner)

func knock():
	knocked = true
	$"3DText".text = "*knocking*"
