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
	target = owner.blackboard["interaction_partner"]
	owner.emote(interact_method)
	owner.get_tree().create_timer(3.0).connect("timeout", self, "complete")
	if owner.translation.distance_to(target.translation) < 1.0:
		owner.navigation.navigate_to(target.translation + Vector3(2.0, 0, 0))
	.on_initialise()

func update() -> int:
	if is_complete:
		return Status.SUCCESS
	elif not target:
		return Status.FAILURE
	owner.navigation.face_target(target.translation)
	return Status.RUNNING

func on_terminate(status) -> void:
	owner.blackboard["interaction_partner"] = null
	is_complete = false
	.on_terminate(status)

func complete() -> void:
	is_complete = true
