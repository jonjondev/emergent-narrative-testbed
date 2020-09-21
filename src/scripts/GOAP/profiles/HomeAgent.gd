class_name HomeAgent
extends GoapAgent

func _init(owner):
	goal_state = {
		HomeStates.StateConditions.IS_HUNGRY: false,
		HomeStates.StateConditions.IS_SLEEPY: false,
		HomeStates.StateConditions.DOOR_UNCHECKED: false,
	}
	actions = [
		EatAction,
		SleepAction,
		SearchAction,
		AnswerDoorAction,
		#RestAction,
	]
	.setup(owner, HomeStates.StateConditions.size())

func generate_current_state():
	var current_state = blank_state.duplicate()
	current_state[HomeStates.StateConditions.IS_HUNGRY] = owner.blackboard.get("hunger") <= 0
	current_state[HomeStates.StateConditions.IS_SLEEPY] = owner.blackboard.get("energy") <= 0
	current_state[HomeStates.StateConditions.DOOR_UNCHECKED] = any_doors_knocked()
	current_state[HomeStates.StateConditions.IS_BORED] = not current_state[HomeStates.StateConditions.IS_SLEEPY] and not current_state[HomeStates.StateConditions.IS_HUNGRY]
	current_state[HomeStates.StateConditions.KNOWS_FOOD] = .check_memory("food")
	current_state[HomeStates.StateConditions.KNOWS_BED] = .check_memory("bed")
	current_state[HomeStates.StateConditions.KNOWS_CHAIR] = .check_memory("chair")
	current_state[HomeStates.StateConditions.KNOWS_DOOR] = .check_memory("door")
	return current_state

func any_doors_knocked() -> bool:
	if owner.blackboard.get("door"):
		for door in owner.blackboard.get("door"):
			if door.knocked:
				return true
	return false
