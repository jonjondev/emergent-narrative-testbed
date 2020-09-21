class_name DMStateMachine

enum State { PLANNING, ACTION }

var agent_profiles: Array = []

# State machine fields
var owner: Node
var current_state: int = State.PLANNING

# Planning fields
var dm_profile: DMAgent
var current_plan: Array = []

# Action fields
var action_setup: bool = false
var current_action: GoapAction = null

func _init(o, profile):
	owner = o
	dm_profile = profile.new(owner)

func on_update():
	match(current_state):
		State.PLANNING:
			# Action transition
			if current_plan and not current_plan.empty():
				current_state = State.ACTION
				on_action_enter()
				on_action_update()
			# Planning update
			else:
				on_planning_update()
		State.ACTION:
			# Planning transition
			if current_plan.empty():
				current_state = State.PLANNING
				on_planning_update()
			# Action update
			else:
				on_action_update()

func on_planning_update():
	var new_plan = generate_plan(dm_profile.generate_current_state())
	if new_plan and current_plan.hash() != new_plan.hash():
		current_plan = new_plan

func on_action_enter():
	current_action = current_plan.front() if current_plan else null

func on_action_update():
	if current_action && GoapPlanner.conditions_valid(dm_profile.generate_current_state(), current_action.preconditions):
		if not action_setup:
			current_action.setup()
			action_setup = true
		if current_action.perform():
			current_plan.remove(0)
			current_action = current_plan.front() if current_plan else null
			action_setup = false
	else:
		current_plan.clear()

func generate_plan(current_state):
	if GoapPlanner.conditions_valid(current_state, dm_profile.goal_state):
		return null
	for agent_profile in agent_profiles:
		if not state_meets_goals(current_state, agent_profile, dm_profile.goal_state):
			for action in dm_profile.actions:
				var new_state = GoapPlanner.apply_effects(current_state, action.effects)
				if state_meets_goals(new_state, agent_profile, dm_profile.goal_state):
					return [action]

func state_meets_goals(current_state, profile, goals):
	var plan = GoapPlanner.generate_plan(current_state, profile)
	if plan:
		return contains_desired_effects(plan, goals)

func contains_desired_effects(plan, goals):
	GoapPlanner.print_plan(plan)
	for action in plan:
		for key in action.effects.keys():
			if goals.has(key) and goals[key] == action.effects[key]:
				goals.erase(key)
	return goals.empty()
