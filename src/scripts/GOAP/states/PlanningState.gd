class_name PlanningState
extends State

var planner = GoapPlanner.new()
var agent_profile = GoapAgent
var states = GoapStates

func _init(owner).(owner):
	agent_profile = agent_profile.new(owner)
	states = states.new(owner)
	owner.blackboard["agent_states"] = states
	owner.blackboard.plan = []

func on_enter():
	pass

func on_update():
	var new_plan = planner.generate_plan(states.generate_current_state(), agent_profile)
	if new_plan and owner.blackboard.plan.hash() != new_plan.hash():
		owner.blackboard.plan = new_plan

func on_exit():
	pass
