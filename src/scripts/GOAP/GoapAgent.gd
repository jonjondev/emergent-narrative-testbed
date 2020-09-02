class_name GoapAgent

var goal_state = {
	GoapStates.StateConditions.IS_HUNGRY: false,
	GoapStates.StateConditions.IS_SLEEPY: false,
	#GoapStates.StateConditions.IS_BORED: false,
}

var actions = [
	EatGoapAction,
	SleepGoapAction,
	SearchGoapAction,
	RestGoapAction,
]

func _init(owner):
	for i in range(actions.size()):
		actions[i] = actions[i].new(owner)
