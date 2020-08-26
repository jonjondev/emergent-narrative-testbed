class_name ActionState
extends State

var current_action
var navigated = false
var setup = false

func _init(owner).(owner):
	pass

func on_enter():
	current_action = owner.blackboard.plan.front() if owner.blackboard.plan else null

func on_update():
	if current_action && GoapPlanner.conditions_valid(owner.blackboard.agent_states.generate_current_state(), current_action.preconditions):
		if not setup:
			current_action.setup()
			setup = true
		if not navigated:
			owner.blackboard.target = current_action.target
			navigated = true
		if current_action.perform():
			owner.blackboard.plan.remove(0)
			current_action = owner.blackboard.plan.front() if owner.blackboard.plan else null
			navigated = false
			setup = false
	else:
		owner.blackboard.plan.clear()

func on_exit():
	pass
