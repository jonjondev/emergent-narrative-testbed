class_name GoapStateMachine

enum State { PLANNING, ACTION, NAVIGATION }

# State machine fields
var owner: Node
var current_state: int = State.PLANNING

# Planning fields
var planner: GoapPlanner = GoapPlanner.new()
var agent_profile: GoapAgent
var states: GoapStates
var current_plan: Array = []

# Action fields
var action_setup: bool = false
var current_action: GoapAction = null

# Navigation fields
const MINIMUM_DISTANCE: float = 1.5
var target = null

func _init(o, profile):
	owner = o
	agent_profile = profile.new(owner)
	states = GoapStates.new(owner)

func on_update():
	match(current_state):
		State.PLANNING:
			# Action transition
			if current_plan and not current_plan.empty():
				current_state = State.ACTION
				on_action_enter()
				on_action_update()
			# Planning update
			else:
				on_planning_update()
		State.ACTION:
			# Navigation transition
			if target:
				current_state = State.NAVIGATION
				on_navigation_enter()
			# Planning transition
			elif current_plan.empty():
				current_state = State.PLANNING
				on_planning_update()
			# Action update
			else:
				on_action_update()
		State.NAVIGATION:
			# Action transition
			if owner.navigation.is_near(get_target_vector(), MINIMUM_DISTANCE):
				target = null
				current_state = State.ACTION
				on_action_enter()
				on_action_update()

func on_planning_update():
	var new_plan = planner.generate_plan(states.generate_current_state(), agent_profile)
	if new_plan and current_plan.hash() != new_plan.hash():
		current_plan = new_plan

func on_action_enter():
	current_action = current_plan.front() if current_plan else null

func on_action_update():
	if current_action && GoapPlanner.conditions_valid(states.generate_current_state(), current_action.preconditions):
		if not action_setup:
			current_action.setup()
			target = current_action.target
			action_setup = true
		if current_action.perform():
			current_plan.remove(0)
			current_action = current_plan.front() if current_plan else null
			action_setup = false
	else:
		current_plan.clear()

func on_navigation_enter():
	owner.navigation.navigate_to(get_target_vector())

func get_target_vector():
	return target if target is Vector3 else target.translation
