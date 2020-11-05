class_name PerformQuestAction
extends UseSmartObjectAction

func _init(o).(o):
	preconditions = {
		ForestStates.StateConditions.HAS_QUEST: true,
	}
	effects = {
		ForestStates.StateConditions.KNOWS_TREASURE: true,
	}

func setup() -> bool:
	target = owner.blackboard.get("quest")
	owner.emote("*questing*")
	return true
