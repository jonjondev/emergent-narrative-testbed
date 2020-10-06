class_name DMAgent
extends GoapAgent

func _init(owner):
	goal_state = {
		HomeStates.StateConditions.DOOR_OPENED: true,
	}
	actions = [
		KnockAction
	]
	.setup(owner)

func generate_current_state():
	var agent = owner.get_tree().get_nodes_in_group("agent")[0]
	return agent.behaviour_algorithm.agent_profile.states.generate_current_state(agent)
