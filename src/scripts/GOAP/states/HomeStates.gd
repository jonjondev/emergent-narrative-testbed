class_name HomeStates
extends GoapStates

enum StateConditions {
	IS_HUNGRY,
	IS_SLEEPY,
	IS_SAFE,
	IS_HOME,
	HAS_GUN,
	DOOR_KNOCKED,
	DOOR_OPENED,
	KNOWS_FOOD,
	KNOWS_BED,
	KNOWS_DOOR,
	KNOWS_GUN,
}

static func generate_current_state(owner):
	var current_state = .generate_base_state(StateConditions.size())
	current_state[StateConditions.IS_HUNGRY] = owner.blackboard.get("hunger") <= 0
	current_state[StateConditions.IS_SLEEPY] = owner.blackboard.get("energy") <= 0
	current_state[StateConditions.IS_SAFE] = not (any_of_group(owner, "fire", "lit") or any_of_group(owner, "intruder", "present"))
	current_state[StateConditions.IS_HOME] = owner != null
	current_state[StateConditions.HAS_GUN] = owner.blackboard.get("has_gun") == true
	current_state[StateConditions.DOOR_KNOCKED] = any_of_group(owner, "door", "knocked")
	current_state[StateConditions.DOOR_OPENED] = any_of_group(owner, "door", "opened")
	current_state[StateConditions.KNOWS_FOOD] = .check_agent_memory(owner, "food")
	current_state[StateConditions.KNOWS_BED] = .check_agent_memory(owner, "bed")
	current_state[StateConditions.KNOWS_DOOR] = .check_agent_memory(owner, "door")
	current_state[StateConditions.KNOWS_GUN] = .check_agent_memory(owner, "gun")
	return current_state

static func any_of_group(owner, group, field) -> bool:
	if owner.blackboard.get(group):
		for object in owner.blackboard.get(group):
			if object.get(field):
				return true
	return false
