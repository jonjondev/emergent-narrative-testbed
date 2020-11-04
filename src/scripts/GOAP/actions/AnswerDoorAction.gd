class_name AnswerDoorAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		HomeStates.StateConditions.KNOWS_DOOR: true,
	}
	effects = {
		HomeStates.StateConditions.DOOR_KNOCKED: false,
		HomeStates.StateConditions.DOOR_OPENED: true,
	}

func setup() -> void:
	target = owner.get_closest("door")
	owner.emote("*opening door*")
