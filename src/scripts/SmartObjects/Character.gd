extends SmartObject

func _init().():
	action_name = "*talking*"
	action_length = 3.0

func _ready():
	self_value = get_parent()

func end_interaction() -> void:
	owner.blackboard["advertising_state"] = false
