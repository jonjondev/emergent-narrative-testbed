class_name HomeAgent
extends GoapAgent

func _init(owner):
	states = HomeStates
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
	.setup(owner)
