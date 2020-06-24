class_name NearCondition
extends Condition

var target_id
var target

func _init(o, id).(o):
	target_id = id

func on_initialise() -> void:
	target = owner.get_tree().get_nodes_in_group(target_id)[0]
	.on_initialise()

func update() -> int:
	if owner.is_near(target):
		return Status.SUCCESS
	return Status.FAILURE
