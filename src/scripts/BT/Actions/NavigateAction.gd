class_name NavigateAction
extends Action

var group_name
var target
var min_distance

func _init(o, group, distance = 1.0).(o):
	group_name = group
	min_distance = distance

func on_initialise() -> void:
	target = owner.blackboard.get(group_name)
	if target and not owner.navigation.is_near(target.self_value.translation, min_distance):
		owner.navigation.navigate_to(target.self_value.translation)
	.on_initialise()

func update() -> int:
	if not owner.navigation.is_navigating():
		if target:
			return Status.SUCCESS
		else:
			owner.navigation.move_to_random_location()
	else:
		for potential_target in owner.perception.get_overlapping_areas():
			if potential_target.is_in_group(group_name) and potential_target.self_value != owner:
				target = potential_target
				owner.blackboard[group_name] = target
				owner.navigation.navigate_to(target.self_value.translation)
	return Status.RUNNING

func on_terminate(status) -> void:
	.on_terminate(status)
