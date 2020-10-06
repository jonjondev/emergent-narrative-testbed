class_name GoapAgent

var goal_state: Dictionary
var actions: Array
var states
var owner

func setup(o):
	owner = o
	for i in range(actions.size()):
		actions[i] = actions[i].new(owner)
