class_name KnockAction
extends GoapAction

func _init(o).(o):
	preconditions = {}
	effects = {
		HomeStates.StateConditions.DOOR_KNOCKED: true,
	}

func perform() -> bool:
	owner.get_tree().get_nodes_in_group("door")[0].knock()
	return true
