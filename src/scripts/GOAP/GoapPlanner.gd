class_name GoapPlanner

static func generate_plan(current_state, profile):
	if conditions_valid(current_state, profile.goal_state):
		return null
	var potential_plans = generate_valid_paths(current_state, profile)
	var selected_plan_idx = 0
	if potential_plans.size() > 0:
		while contains_indirection(potential_plans[selected_plan_idx]) and selected_plan_idx < potential_plans.size() - 1:
			selected_plan_idx += 1
		return potential_plans[selected_plan_idx]
	return []

static func generate_valid_paths(current_state, profile):
	var found_plans = []
	var checked_actions = []
	var potential_state_paths = [new_state_path(current_state, [])]
	while not potential_state_paths.empty():
		var state_path = potential_state_paths.pop_front()
		for action in profile.actions:
			if checked_actions.has(action):
				continue
			if conditions_valid(state_path.conditions, action.preconditions):
				var new_actions = state_path.actions.duplicate()
				new_actions.append(action)
				var action_state = apply_effects(state_path.conditions, action.effects)
				if conditions_valid(action_state, profile.goal_state):
					found_plans.append(new_actions)
				else:
					potential_state_paths.append(new_state_path(action_state, new_actions))
					checked_actions.append(action)
	return found_plans

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

static func contains_indirection(plan):
	for action in plan:
		if action.is_indirect:
			return true
	return false

static func new_state_path(conditions, actions):
	return { "conditions": conditions, "actions": actions}

static func get_script_name(action):
	return action.get_script().resource_path.split("/")[-1].split(".")[0]

static func print_plan(plan):
	var p = "["
	for action in plan:
		p += (get_script_name(action) + ", ")
	print(p.rstrip(", ") + "]")
