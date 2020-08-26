class_name NavigationState
extends State

func _init(owner).(owner):
	pass

func on_enter():
	if owner.blackboard.target is Vector3:
		owner.navigation.navigate_to(owner.blackboard.target)
	else:
		owner.navigation.navigate_to(owner.blackboard.target.translation)

func on_update():
	pass

func on_exit():
	pass
