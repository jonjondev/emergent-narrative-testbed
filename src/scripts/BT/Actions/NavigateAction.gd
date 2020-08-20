class_name NavigateAction
extends Action

var group_name
var target
var min_distance

func _init(o, group, distance = 1.0).(o):
	group_name = group
	min_distance = distance

func on_initialise() -> void:
	check_memory()
	.on_initialise()

func update() -> int:
	if not owner.navigation.is_navigating():
		if target:
			return Status.SUCCESS
		else:
			owner.navigation.move_to_random_location()
	else:
		check_memory()
	return Status.RUNNING

func on_terminate(status) -> void:
	.on_terminate(status)

func check_memory() -> void:
	var potential_targets = owner.blackboard.get(group_name)
	if potential_targets:
		target = owner.navigation.get_closest(potential_targets)
		if not owner.navigation.is_near(target.self_value.translation, min_distance):
			owner.navigation.navigate_to(target.self_value.translation)
