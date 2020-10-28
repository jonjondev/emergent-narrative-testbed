class_name DMStateMachine

enum State { PLANNING, ACTION }

# State machine fields
var owner: Node
var current_state: int = State.PLANNING

# Planning fields
var dm_profile: DMAgent

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
			if current_action:
				current_state = State.ACTION
				on_action_update()
			# Planning update
			else:
				on_planning_update()
		State.ACTION:
			# Planning transition
			if not current_action:
				current_state = State.PLANNING
				on_planning_update()
			# Action update
			else:
				on_action_update()

func on_planning_update():
	if dm_profile.goal_state.empty() and not dm_profile.goal_states.empty():
		var new_state = dm_profile.goal_states.pop_front()
		dm_profile.goal_state[new_state.condition] = new_state.value
	var agents = owner.get_tree().get_nodes_in_group("agent")
	if agents.size() > 0:
		current_action = generate_dm_plan(dm_profile.states.generate_current_state(agents[0]), agents)

func on_action_update():
	if current_action && GoapPlanner.conditions_valid(dm_profile.states.generate_current_state(owner.get_tree().get_nodes_in_group("agent")[0]), current_action.preconditions):
		if not action_setup:
			current_action.setup()
			action_setup = true
		if current_action.perform():
			current_action = null
			action_setup = false
	else:
		current_action = null

func generate_dm_plan(initial_state, agents):
	if GoapPlanner.conditions_valid(initial_state, dm_profile.goal_state):
		dm_profile.goal_state.clear()
		return null
	for agent in agents:
		var agent_profile = agent.behaviour_algorithm.agent_profile
		if not state_meets_goals(initial_state, agent_profile, dm_profile.goal_state):
			for action in dm_profile.actions:
				var new_state = GoapPlanner.apply_effects(initial_state, action.effects)
				if state_meets_goals(new_state, agent_profile, dm_profile.goal_state):
					return action

func state_meets_goals(initial_state, profile, goals):
	var plan = GoapPlanner.generate_plan(initial_state, profile)
	return contains_desired_effects(plan, goals.duplicate()) if plan else null

func contains_desired_effects(plan, goals):
	for action in plan:
		for key in action.effects.keys():
			if goals.has(key) and goals[key] == action.effects[key]:
				goals.erase(key)
	return goals.empty()
