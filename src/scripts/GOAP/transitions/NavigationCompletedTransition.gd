class_name NavigationCompletedTransition
extends Transition

func _init(owner).(owner):
	pass

func is_valid():
	if owner.blackboard.target is Vector3:
		return owner.navigation.is_near(owner.blackboard.target)
	return owner.navigation.is_near(owner.blackboard.target.translation)

func on_transition():
	owner.blackboard.target = null
