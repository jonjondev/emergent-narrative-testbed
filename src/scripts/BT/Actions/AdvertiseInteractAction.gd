class_name AdvertiseInteractAction
extends Action

var interact_method
var group_name
var has_failed

func _init(o, group, method).(o):
	interact_method = method
	group_name = group

func on_initialise() -> void:
	owner.is_advertising = true
	owner.emote("*advertising*")
	owner.get_tree().create_timer(2.0).connect("timeout", self, "fail")
	.on_initialise()

func update() -> int:
	if has_failed:
		return Status.FAILURE
	for area in owner.perception.get_overlapping_areas():
		var agent = area.get_node("..")
		if area.is_in_group(group_name) and agent != owner:
			if agent.is_advertising or agent.blackboard.get("interaction_partner") == owner:
				owner.blackboard["interaction_partner"] = agent
				return Status.SUCCESS
	return Status.RUNNING

func on_terminate(status) -> void:
	has_failed = false
	owner.is_advertising = false
	.on_terminate(status)

func fail() -> void:
	has_failed = true
