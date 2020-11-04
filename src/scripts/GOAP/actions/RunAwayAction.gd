class_name RunAwayAction
extends UseSmartObjectAction

func _init(o).(o):
	is_indirect = true
	preconditions = {
		HomeStates.StateConditions.DOOR_OPENED: true,
	}
	effects = {
		HomeStates.StateConditions.IS_SAFE: true,
		HomeStates.StateConditions.IS_HOME: false,
	}

func setup() -> void:
	target = owner.get_tree().get_nodes_in_group("exit")[0]
	owner.emote("*running away*")
