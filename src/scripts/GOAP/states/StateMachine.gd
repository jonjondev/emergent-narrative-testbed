class_name StateMachine
extends State

var current_state
var instanced_states = []
var transition_state_map = {}

func _init(o).(o):
	pass

func setup():
	current_state = current_state.new(owner)
	for state in transition_state_map.keys():
		for transition_state in transition_state_map[state]:
			transition_state[0] = transition_state[0].new(owner)

func on_enter():
	instanced_states.append(current_state)
	current_state.on_enter()

func on_update():
	var transition_states = transition_state_map[current_state.get_script()]
	for transition_state in transition_states:
		if transition_state[0].is_valid():
			current_state.on_exit()
			transition_state[0].on_transition()
			current_state = get_state(transition_state[1])
			current_state.on_enter()
			break
	current_state.on_update()

func on_exit():
	pass

func get_state(state_class):
	for state in instanced_states:
		if state is state_class:
			return state
	var new_state = state_class.new(owner)
	instanced_states.append(new_state)
	return new_state
