class_name NavigateAction
extends Action

var group_name
var target
var offset_distance

func _init(o, group, offset = 1.0).(o):
	group_name = group
	offset_distance = offset

func on_initialise() -> void:
	target = owner.blackboard.get(group_name)
	if target and not owner.navigation.is_near(target.translation, offset_distance):
		owner.navigation.navigate_to(target.translation)
	.on_initialise()

func update() -> int:
	if not owner.navigation.is_navigating():
		if target:
			return Status.SUCCESS
		else:
			owner.navigation.move_to_random_location()
	else:
		for potential_target in owner.perception.get_overlapping_areas():
			if potential_target.is_in_group(group_name):
				owner.blackboard[group_name] = potential_target
				target = potential_target
				owner.navigation.navigate_to(target.translation)
	return Status.RUNNING

func on_terminate(status) -> void:
	.on_terminate(status)
