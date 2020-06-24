class_name NavigateAction
extends Action

var target_id
var target

func _init(o, id).(o):
	target_id = id

func on_initialise() -> void:
	target = owner.get_tree().get_nodes_in_group(target_id)[0]
	owner.set_path_to(target.translation)
	.on_initialise()

func update() -> int:
	if owner.thinking:
		return Status.SUCCESS
	return Status.RUNNING

func on_terminate(status) -> void:
	.on_terminate(status)
