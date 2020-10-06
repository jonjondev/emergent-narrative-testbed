extends Spatial

var blackboard = {}

var behaviour_algorithm: DMStateMachine

func _ready():
	behaviour_algorithm = DMStateMachine.new(self, DMAgent)
	var _err = $AITime.connect("timeout", self, "ai_process")
	_err = get_tree().create_timer($AITime.wait_time).connect("timeout", self, "setup")

func setup() -> void:
	var all_profiles = owner.get_tree().get_nodes_in_group("agent")[0].behaviour_algorithm.agent_profile
	behaviour_algorithm.agent_profiles.append(all_profiles)

func ai_process() -> void:
	behaviour_algorithm.on_update()
