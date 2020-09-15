extends Spatial

var blackboard = {}

var behaviour_algorithm: DMStateMachine

func _ready():
	behaviour_algorithm = DMStateMachine.new(self, DMAgent)
	var _err = $AITime.connect("timeout", self , "ai_process")

func ai_process() -> void:
	behaviour_algorithm.on_update()
