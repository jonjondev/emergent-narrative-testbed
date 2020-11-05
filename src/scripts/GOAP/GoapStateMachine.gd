class_name GoapStateMachine

enum State { PLANNING, ACTION, NAVIGATION }

const MINIMUM_DISTANCE: float = 1.5

var owner: Node
var agent_profile: GoapAgent

var current_state: int = State.PLANNING
var current_plan: Array = []

var current_action: GoapAction = null
var action_setup: bool = false
var target = null

func _init(o, profile):
	owner = o
	agent_profile = profile.new(owner)

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
			if owner.navigation.is_near(get_as_location(target), MINIMUM_DISTANCE):
				target = null
				current_state = State.ACTION
				on_action_enter()
				on_action_update()

func on_planning_update():
	var new_plan = GoapPlanner.generate_plan(agent_profile.states.generate_current_state(owner), agent_profile)
	if new_plan and current_plan.hash() != new_plan.hash():
		current_plan = new_plan
		GoapPlanner.print_plan(current_plan)

func on_action_enter():
	current_action = current_plan.front() if current_plan else null

func on_action_update():
	if current_action && GoapPlanner.conditions_valid(agent_profile.states.generate_current_state(owner), current_action.preconditions):
		if not action_setup:
			var _success = current_action.setup()
			target = current_action.target
			action_setup = true
		if current_action.perform():
			current_plan.remove(0)
			current_action = current_plan.front() if current_plan else null
			action_setup = false
	else:
		current_plan.clear()
		action_setup = false

func on_navigation_enter():
	owner.navigation.navigate_to(get_as_location(target))

static func get_as_location(object):
	return object if object is Vector3 else object.translation
