class_name SearchGoapAction
extends GoapAction

func _init(o).(o):
	preconditions = {}
	effects = {
		GoapStates.StateConditions.KNOWS_FOOD: true,
		GoapStates.StateConditions.KNOWS_BED: true,
		GoapStates.StateConditions.KNOWS_CHAIR: true,
	}

func setup() -> void:
	target = owner.navigation.generate_random_location()
	owner.emote("*seaching*")

func perform() -> bool:
	if target and owner.navigation.is_near(target):
		owner.emote("")
		return true
	return false
