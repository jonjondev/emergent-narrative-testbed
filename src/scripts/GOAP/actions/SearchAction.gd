class_name SearchAction
extends GoapAction

func _init(o).(o):
	is_indirect = true
	preconditions = {}
	effects = {
		HomeStates.StateConditions.KNOWS_FOOD: true,
		HomeStates.StateConditions.KNOWS_BED: true,
		HomeStates.StateConditions.KNOWS_CHAIR: true,
		HomeStates.StateConditions.KNOWS_DOOR: true,
		HomeStates.StateConditions.KNOWS_GUN: true,
		#ForestStates.StateConditions.KNOWS_QUESTGIVER: true,
		#ForestStates.StateConditions.KNOWS_TREASURE: true,
	}

func setup() -> void:
	target = owner.navigation.generate_random_location()
	owner.emote("*seaching*")

func perform() -> bool:
	if target and owner.navigation.is_near(target):
		owner.emote("")
		return true
	return false
