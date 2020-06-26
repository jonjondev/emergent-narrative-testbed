class_name NavigateAction
extends Action

var group_name
var target

func _init(o, group).(o):
	group_name = group

func on_initialise() -> void:
	target = owner.blackboard.get(group_name)
	if target and not owner.navigation.is_near(target.translation):
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
