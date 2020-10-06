class_name GoapStates

func generate_base_state(num_states) -> Array:
	var current_state = []
	for _i in range(num_states):
		current_state.append(null)
	return current_state

func check_agent_memory(owner, group_name):
	return true if owner.blackboard.get(group_name) else false
