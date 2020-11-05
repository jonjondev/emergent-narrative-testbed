class_name GoapAgent

var owner
var goal_state: Dictionary
var actions: Array
var states

func setup(o):
	owner = o
	for i in range(actions.size()):
		actions[i] = actions[i].new(owner)
