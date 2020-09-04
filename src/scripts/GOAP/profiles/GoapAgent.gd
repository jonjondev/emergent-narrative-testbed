class_name GoapAgent

var goal_state: Dictionary
var actions: Array

var owner
var blank_state = []

func setup(o, states_size):
	owner = o
	for i in range(actions.size()):
		actions[i] = actions[i].new(owner)
	for _i in range(states_size):
		blank_state.append(null)

func generate_current_state():
	var current_state = blank_state.duplicate()
	return current_state

func check_memory(group_name):
	return true if owner.blackboard.get(group_name) else false
