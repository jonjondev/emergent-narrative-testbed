class_name GoapStates

enum StateConditions {
	IS_HUNGRY,
	IS_SLEEPY,
	IS_BORED,
	KNOWS_FOOD,
	KNOWS_BED,
	KNOWS_CHAIR,
}

var owner
var blank_state = []

func _init(o):
	owner = o
	for _i in range(StateConditions.size()):
		blank_state.append(null)

func generate_current_state():
	var current_state = blank_state.duplicate()
	current_state[StateConditions.IS_HUNGRY] = owner.blackboard.get("hunger") <= 0
	current_state[StateConditions.IS_SLEEPY] = owner.blackboard.get("energy") <= 0
	current_state[StateConditions.IS_BORED] = not current_state[StateConditions.IS_SLEEPY] and not current_state[StateConditions.IS_HUNGRY]
	current_state[StateConditions.KNOWS_FOOD] = check_memory("food")
	current_state[StateConditions.KNOWS_BED] = check_memory("bed")
	current_state[StateConditions.KNOWS_CHAIR] = check_memory("chair")
	return current_state

func check_memory(group_name):
	return true if owner.blackboard.get(group_name) else false
