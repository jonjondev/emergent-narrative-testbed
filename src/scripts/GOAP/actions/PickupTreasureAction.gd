class_name PickupTreasureAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		ForestStates.StateConditions.KNOWS_TREASURE: true,
	}
	effects = {
		ForestStates.StateConditions.HAS_TREASURE: true,
	}

func setup() -> bool:
	target = owner.get_closest("treasure")
	owner.emote("*plundering*")
	return true
