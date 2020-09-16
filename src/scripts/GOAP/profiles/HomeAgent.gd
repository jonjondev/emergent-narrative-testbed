class_name HomeAgent
extends GoapAgent

func _init(owner):
	goal_state = {
		HomeStates.StateConditions.IS_HUNGRY: false,
		HomeStates.StateConditions.IS_SLEEPY: false,
		HomeStates.StateConditions.IS_BORED: false,
	}
	actions = [
		EatAction,
		SleepAction,
		SearchAction,
		#RestAction,
	]
	.setup(owner, HomeStates.StateConditions.size())

func generate_current_state():
	var current_state = blank_state.duplicate()
	current_state[HomeStates.StateConditions.IS_HUNGRY] = owner.blackboard.get("hunger") <= 0
	current_state[HomeStates.StateConditions.IS_SLEEPY] = owner.blackboard.get("energy") <= 0
	current_state[HomeStates.StateConditions.IS_BORED] = not current_state[HomeStates.StateConditions.IS_SLEEPY] and not current_state[HomeStates.StateConditions.IS_HUNGRY]
	current_state[HomeStates.StateConditions.KNOWS_FOOD] = .check_memory("food")
	current_state[HomeStates.StateConditions.KNOWS_BED] = .check_memory("bed")
	current_state[HomeStates.StateConditions.KNOWS_CHAIR] = .check_memory("chair")
	return current_state
