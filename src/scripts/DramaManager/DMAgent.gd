class_name DMAgent
extends GoapAgent

func _init(owner):
	goal_state = {
		DMStates.StateConditions.HERO_HAS_TREASURE: true,
	}
	actions = [
		
	]
	.setup(owner, DMStates.StateConditions.size())

func generate_current_state():
	var current_state = blank_state.duplicate()
	var hero = owner.get_tree().get_nodes_in_group("hero")[0]
	current_state[DMStates.StateConditions.HERO_HAS_TREASURE] = hero.blackboard.get("has_loot")
	current_state[DMStates.StateConditions.HERO_HAS_QUEST] = hero.blackboard.get("quest") != null
	current_state[DMStates.StateConditions.HERO_KNOWS_TREASURE] = check_agent_memory(hero, "treasure")
	current_state[DMStates.StateConditions.HERO_KNOWS_QUESTGIVER] = check_agent_memory(hero, "questgiver")
	return current_state

func check_agent_memory(agent, group_name):
	return true if agent.blackboard.get(group_name) else false
