class_name InteractAction
extends Action

var target
var group_name
var interact_method
var is_complete

func _init(o, group, method).(o):
	interact_method = method
	group_name = group

func on_initialise() -> void:
	for potential_target in owner.get_tree().get_nodes_in_group(group_name):
		if potential_target != owner:
			target = potential_target
	owner.emote(interact_method)
	target.get_node("..").initiate_interaction(interact_method)
	owner.get_tree().create_timer(3.0).connect("timeout", self, "complete")
	.on_initialise()

func update() -> int:
	if is_complete:
		return Status.SUCCESS
	elif not target:
		return Status.FAILURE
	return Status.RUNNING

func on_terminate(status) -> void:
	is_complete = false
	.on_terminate(status)

func complete() -> void:
	target.get_node("..").end_interaction()
	is_complete = true
