class_name DMStateMachine

enum State { PLANNING, ACTION }

var agent_profiles: Array = []

# State machine fields
var owner: Node
var current_state: int = State.PLANNING

# Planning fields
var dm_profile: DMAgent

# Action fields
var action_setup: bool = false
var current_action: GoapAction = null

func _init(o, profile):
	owner = o
	dm_profile = profile.new(owner)

func on_update():
	match(current_state):
		State.PLANNING:
			# Action transition
			if current_action:
				current_state = State.ACTION
				on_action_update()
			# Planning update
			else:
				on_planning_update()
		State.ACTION:
			# Planning transition
			if not current_action:
				current_state = State.PLANNING
				on_planning_update()
			# Action update
			else:
				on_action_update()

func on_planning_update():
	var agents = owner.get_tree().get_nodes_in_group("agent")
	var potential_actions = []
	for agent in agents:
		var new_action = generate_plan(dm_profile.states.generate_current_state(agent))
		if new_action:
			potential_actions.append(new_action)
	if potential_actions.size() > 0 and potential_actions[0] != current_action:
		current_action = potential_actions[0]

func on_action_update():
	if current_action && GoapPlanner.conditions_valid(dm_profile.states.generate_current_state(owner.get_tree().get_nodes_in_group("agent")[0]), current_action.preconditions):
		if not action_setup:
			current_action.setup()
			action_setup = true
		if current_action.perform():
			current_action = null
			action_setup = false
	else:
		current_action = null

func generate_plan(initial_state):
	if GoapPlanner.conditions_valid(initial_state, dm_profile.goal_state):
		return null
	for agent_profile in agent_profiles:
		if not state_meets_goals(initial_state, agent_profile, dm_profile.goal_state):
			for action in dm_profile.actions:
				var new_state = GoapPlanner.apply_effects(initial_state, action.effects)
				if state_meets_goals(new_state, agent_profile, dm_profile.goal_state):
					return action

func state_meets_goals(initial_state, profile, goals):
	var plan = GoapPlanner.generate_plan(initial_state, profile)
	if plan:
		return contains_desired_effects(plan, goals)

func contains_desired_effects(plan, goals):
	for action in plan:
		for key in action.effects.keys():
			if goals.has(key) and goals[key] == action.effects[key]:
				goals.erase(key)
	return goals.empty()
