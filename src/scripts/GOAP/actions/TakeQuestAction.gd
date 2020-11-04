class_name TakeQuestAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		ForestStates.StateConditions.KNOWS_QUESTGIVER: true,
	}
	effects = {
		ForestStates.StateConditions.HAS_QUEST: true,
	}

func setup() -> void:
	target = owner.get_closest("questgiver")
	owner.emote("*quest-finding*")
