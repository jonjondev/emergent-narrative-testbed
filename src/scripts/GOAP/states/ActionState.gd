class_name ActionState
extends State

var current_action
var navigated = false

func _init(owner).(owner):
	pass

func on_enter():
	current_action = owner.blackboard.plan.front() if owner.blackboard.plan else null

func on_update():
	if current_action:
		if not navigated:
			owner.blackboard.target = current_action.target
			navigated = true
		if current_action.perform():
			current_action = owner.blackboard.plan.remove(0)
			current_action = owner.blackboard.plan.front() if owner.blackboard.plan else null
			navigated = false

func on_exit():
	pass
