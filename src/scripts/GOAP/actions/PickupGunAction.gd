class_name PickupGunAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		HomeStates.StateConditions.KNOWS_GUN: true,
	}
	effects = {
		HomeStates.StateConditions.HAS_GUN: true,
	}

func setup() -> bool:
	target = owner.get_closest("gun")
	owner.emote("*getting gun*")
	return true
