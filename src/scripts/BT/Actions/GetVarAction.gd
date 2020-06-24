class_name GetVarAction
extends Action

var value_id
var value

func _init(o, id, v).(o):
	value_id = id
	value = v

func update() -> int:
	return Status.SUCCESS if owner.blackboard.get(value_id) == value else Status.FAILURE
