class_name InteractAction
extends Action

var target
var is_complete
var group_name

func _init(o, group = null).(o):
	group_name = group

func on_initialise() -> void:
	target = owner.blackboard.get(group_name)
	var interaction_data = target.interact(owner)
	owner.emote(interaction_data.name)
	owner.get_tree().create_timer(interaction_data.length).connect("timeout", self, "complete")
	.on_initialise()

func update() -> int:
	if is_complete:
		target.end_interaction()
		return Status.SUCCESS
	elif not target:
		return Status.FAILURE
	target.tick_interaction(owner)
	return Status.RUNNING

func on_terminate(status) -> void:
	is_complete = false
	.on_terminate(status)

func complete() -> void:
	if current_status == Status.RUNNING:
		is_complete = true
