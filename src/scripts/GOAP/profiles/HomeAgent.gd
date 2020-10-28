class_name HomeAgent
extends GoapAgent

func _init(owner):
	states = HomeStates
	goal_state = {
		HomeStates.StateConditions.IS_SAFE: true,
		HomeStates.StateConditions.IS_HUNGRY: false,
		HomeStates.StateConditions.IS_SLEEPY: false,
		HomeStates.StateConditions.DOOR_KNOCKED: false,
	}
	actions = [
		RunAwayAction,
		SearchAction,
		PickupGunAction,
		AnswerDoorAction,
		EatAction,
		SleepAction,
	]
	.setup(owner)
