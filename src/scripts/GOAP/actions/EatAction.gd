class_name EatAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		HomeStates.StateConditions.KNOWS_FOOD: true,
	}
	effects = {
		HomeStates.StateConditions.IS_HUNGRY: false,
	}

func setup() -> void:
	target = owner.get_closest("food")
	owner.emote("*hungry*")
