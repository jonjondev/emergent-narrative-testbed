class_name DMAgent
extends GoapAgent

var goal_states = [
	{ "condition": HomeStates.StateConditions.DOOR_OPENED, "value": true},
	{ "condition": HomeStates.StateConditions.IS_HOME, "value": false},
]

func _init(owner):
	states = HomeStates
	goal_state = {}
	actions = [
		KnockAction,
		StartFireAction,
	]
	.setup(owner)
