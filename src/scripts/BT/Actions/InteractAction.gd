class_name InteractAction
extends Action

var target
var is_complete
var group_name

func _init(o, group = null).(o):
	group_name = group

func on_initialise() -> void:
	target = owner.blackboard.get(group_name) if group_name else owner.blackboard.get("interaction_partner")
	var interaction_data = target.interact(owner)
	owner.emote(interaction_data.name)
	owner.get_tree().create_timer(interaction_data.length).connect("timeout", self, "complete")
	.on_initialise()

func update() -> int:
	if is_complete:
		return Status.SUCCESS
	elif not target:
		return Status.FAILURE
	return Status.RUNNING

func on_terminate(status) -> void:
	owner.blackboard["interaction_partner"] = null
	is_complete = false
	.on_terminate(status)

func complete() -> void:
	is_complete = true
