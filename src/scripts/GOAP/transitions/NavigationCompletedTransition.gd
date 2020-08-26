class_name NavigationCompletedTransition
extends Transition

func _init(owner).(owner):
	pass

func is_valid():
	return owner.is_near(owner.blackboard.target)

func on_transition():
	owner.blackboard.target = null
