class_name NearPrecondition
extends Precondition

var target_id
var target

func _init(o, target, child).(o, child):
	target_id = target

func on_initialise() -> void:
	target = owner.get_tree().get_nodes_in_group(target_id)[0]
	.on_initialise()

func update() -> int:
	if owner.is_near(target):
		return child.tick()
	return Status.FAILURE
