class_name PerformQuestGoapAction
extends GoapAction

func _init(o).(o):
	preconditions = {
		ForestStates.StateConditions.HAS_QUEST: true,
	}
	effects = {
		ForestStates.StateConditions.KNOWS_TREASURE: true,
	}

func setup() -> void:
	target = owner.blackboard.get("quest")
	owner.emote("*questing*")

func perform():
	if owner.navigation.is_near(target, 1.5):
		reset()
		return true
	return false

func reset() -> void:
	owner.emote("")
