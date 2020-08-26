class_name NavigationRequiredTransition
extends Transition

func _init(owner).(owner):
	pass

func is_valid():
	return owner.blackboard.target

func on_transition():
	pass
