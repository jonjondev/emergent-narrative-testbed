class_name SleepAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		HomeStates.StateConditions.KNOWS_BED: true,
	}
	effects = {
		HomeStates.StateConditions.IS_SLEEPY: false,
	}

func setup() -> void:
	target = owner.get_closest("bed")
	owner.emote("*sleepy*")
