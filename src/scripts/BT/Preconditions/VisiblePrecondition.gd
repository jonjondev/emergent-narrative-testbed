class_name VisiblePrecondition
extends Precondition

var target_id
var target

func _init(o, id, child).(o, child):
	target_id = id

func on_initialise() -> void:
	target = owner.get_tree().get_nodes_in_group(target_id)[0]
	.on_initialise()

func update() -> int:
	if target and target.visible:
		return child.tick()
	else:
		return Status.FAILURE
