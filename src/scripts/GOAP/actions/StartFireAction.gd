class_name StartFireAction
extends GoapAction

func _init(o).(o):
	preconditions = {}
	effects = {
		HomeStates.StateConditions.IS_SAFE: false,
	}

func perform() -> bool:
	owner.get_tree().get_nodes_in_group("fire")[0].start_fire()
	return true
