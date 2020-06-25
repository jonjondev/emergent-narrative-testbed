class_name NavigateAction
extends Action

var target_id
var target

func _init(o, id).(o):
	target_id = id

func on_initialise() -> void:
	target = owner.get_tree().get_nodes_in_group(target_id)[0]
	owner.navigation.navigate_to(target.translation)
	.on_initialise()

func update() -> int:
	if owner.navigation.is_navigating():
		return Status.RUNNING
	return Status.SUCCESS
	

func on_terminate(status) -> void:
	.on_terminate(status)
