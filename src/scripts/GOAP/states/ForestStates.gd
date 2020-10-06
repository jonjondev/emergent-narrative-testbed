class_name ForestStates
extends GoapStates

enum StateConditions {
	HAS_TREASURE,
	KNOWS_TREASURE,
	KNOWS_QUESTGIVER,
	HAS_QUEST,
}

func generate_current_state(owner):
	var current_state = .generate_base_state(StateConditions.size())
	current_state[StateConditions.HAS_TREASURE] = owner.blackboard.get("has_loot")
	current_state[StateConditions.HAS_QUEST] = owner.blackboard.get("quest") != null
	current_state[StateConditions.KNOWS_TREASURE] = .check_agent_memory(owner, "treasure")
	current_state[StateConditions.KNOWS_QUESTGIVER] = .check_agent_memory(owner, "questgiver")
	return current_state
