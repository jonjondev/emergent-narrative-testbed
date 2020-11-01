class_name GoapStates

static func generate_base_state(num_states) -> Array:
	var current_state = []
	for _i in range(num_states):
		current_state.append(null)
	return current_state

static func check_agent_memory(owner, group_name) -> bool:
	return true if owner.blackboard.get(group_name) else false

static func any_of_group(owner, group, field) -> bool:
	if owner.blackboard.get(group):
		for object in owner.blackboard.get(group):
			if object.get(field):
				return true
	return false
