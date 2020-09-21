class_name KnockAction
extends GoapAction

func _init(o).(o):
	preconditions = {}
	effects = {
		HomeStates.StateConditions.DOOR_UNCHECKED: true,
	}

func perform():
	owner.get_tree().get_nodes_in_group("door")[0].knock()
	return true
