class_name DMAgent
extends GoapAgent

func _init(owner):
	states = HomeStates
	goal_state = {
		HomeStates.StateConditions.DOOR_OPENED: true,
	}
	actions = [
		KnockAction
	]
	.setup(owner)
