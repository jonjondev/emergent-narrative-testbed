class_name CompletedActionsTransition
extends Transition

func _init(owner).(owner):
	pass

func is_valid():
	return owner.blackboard.plan.empty()

func on_transition():
	pass
