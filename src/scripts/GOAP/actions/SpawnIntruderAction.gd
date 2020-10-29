class_name SpawnIntruder
extends GoapAction

var intruder_available = true

func _init(o).(o):
	preconditions = {}
	effects = {
		HomeStates.StateConditions.IS_SAFE: false,
	}

func setup():
	return intruder_available

func perform():
	owner.get_tree().get_nodes_in_group("intruder")[0].intrude()
	intruder_available = false
	return true
