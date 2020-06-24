class_name SetVarAction
extends Action

var value_id
var value

func _init(o, id, v).(o):
	value_id = id
	value = v

func update() -> int:
	owner.blackboard[value_id] = value
	return Status.SUCCESS
