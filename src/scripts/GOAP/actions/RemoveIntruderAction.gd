class_name RemoveIntruderAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		HomeStates.StateConditions.HAS_GUN: true,
	}
	effects = {
		HomeStates.StateConditions.IS_SAFE: true,
		HomeStates.StateConditions.HAS_GUN: false,
	}

func setup() -> bool:
	target = owner.get_tree().get_nodes_in_group("intruder")[0]
	owner.emote("*removing intruder*")
	return true
