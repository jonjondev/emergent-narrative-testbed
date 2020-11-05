class_name SpawnIntruder
extends GoapAction

var intruder_available = true

func _init(o).(o):
	preconditions = {}
	effects = {
		HomeStates.StateConditions.IS_SAFE: false,
	}

func setup() -> bool:
	return intruder_available

func perform() -> bool:
	intruder_available = false
	owner.get_tree().get_nodes_in_group("intruder")[0].intrude()
	return true
