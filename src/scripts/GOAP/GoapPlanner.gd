class_name GoapPlanner

static func generate_plan(current_state, profile):
	return generate_valid_paths(current_state, profile) if not conditions_valid(current_state, profile.goal_state) else null

static func generate_valid_paths(current_state, profile):
	var found_plans = []
	var checked_actions = []
	var potential_state_paths = [[current_state, []]]
	while not potential_state_paths.empty():
		var state_path = potential_state_paths.pop_front()
		for action in profile.actions:
			if checked_actions.has(action):
				continue
			elif conditions_valid(state_path[0], action.preconditions):
				var new_actions = state_path[1].duplicate()
				new_actions.append(action)
				var action_state = apply_effects(state_path[0], action.effects)
				checked_actions.append(action)
				if conditions_valid(action_state, profile.goal_state):
					found_plans.append(new_actions)
					#return new_actions
				else:
					potential_state_paths.append([action_state, new_actions])
	return found_plans[0]

static func conditions_valid(state, conditions):
	for condition in conditions.keys():
		if state[condition] != conditions[condition]:
			return false
	return true

static func apply_effects(state, effects):
	var new_state = state.duplicate()
	for effect in effects.keys():
		new_state[effect] = effects[effect]
	return new_state
