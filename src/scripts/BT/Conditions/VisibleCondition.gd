class_name VisibleCondition
extends Condition

var target_id
var target

func _init(o, target).(o):
	target_id = target

func on_initialise() -> void:
	target = owner.get_tree().get_nodes_in_group(target_id)[0]
	.on_initialise()

func update() -> int:
	if target and target.visible:
		return Status.SUCCESS
	return Status.FAILURE
