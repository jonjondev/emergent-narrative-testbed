class_name NavigationState
extends State

func _init(owner).(owner):
	pass

func on_enter():
	owner.navigation.target = owner.blackboard.target

func on_update():
	pass

func on_exit():
	owner.navigation.target = null
