class_name GoapPlanner

var agent_profile
var checked_actions

func generate_plan(current_state, agent):
	agent_profile = agent
	checked_actions = []
	return generate_valid_paths(current_state) if not conditions_valid(current_state, agent_profile.goal_state) else null

func generate_valid_paths(current_state):
	var potential_state_paths = [[current_state, []]]
	while not potential_state_paths.empty():
		var state_path = potential_state_paths.pop_front()
		for action in agent_profile.actions:
			if checked_actions.has(action):
				continue
			elif conditions_valid(state_path[0], action.preconditions):
				var new_actions = state_path[1].duplicate()
				new_actions.append(action)
				var action_state = apply_effects(state_path[0], action.effects)
				checked_actions.append(action)
				if conditions_valid(action_state, agent_profile.goal_state):
					return new_actions
				else:
					potential_state_paths.append([action_state, new_actions])

func conditions_valid(state, conditions):
	for condition in conditions.keys():
		if state[condition] != conditions[condition]:
			return false
	return true

func apply_effects(state, effects):
	var new_state = state.duplicate()
	for effect in effects.keys():
		new_state[effect] = effects[effect]
	return new_state
