class_name HeroAgent
extends GoapAgent

func _init(owner):
	goal_state = {
		ForestStates.StateConditions.HAS_TREASURE: true,
	}
	actions = [
		TakeQuestGoapAction,
		PerformQuestGoapAction,
		PickupTreasureGoapAction,
		SearchGoapAction,
	]
	.setup(owner, ForestStates.StateConditions.size())

func generate_current_state():
	var current_state = blank_state.duplicate()
	current_state[ForestStates.StateConditions.HAS_TREASURE] = owner.blackboard.get("has_loot")
	current_state[ForestStates.StateConditions.HAS_QUEST] = owner.blackboard.get("quest") != null
	current_state[ForestStates.StateConditions.KNOWS_TREASURE] = .check_memory("treasure")
	current_state[ForestStates.StateConditions.KNOWS_QUESTGIVER] = .check_memory("questgiver")
	return current_state
