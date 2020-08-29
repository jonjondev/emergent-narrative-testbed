class_name NavigationCompletedTransition
extends Transition

const MINIMUM_DISTANCE: float = 1.5

func _init(owner).(owner):
	pass

func is_valid():
	if owner.blackboard.target is Vector3:
		return owner.navigation.is_near(owner.blackboard.target, MINIMUM_DISTANCE)
	return owner.navigation.is_near(owner.blackboard.target.translation, MINIMUM_DISTANCE)

func on_transition():
	owner.blackboard.target = null
