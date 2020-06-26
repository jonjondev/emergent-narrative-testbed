extends KinematicBody

var behaviour_algorithm: BehaviourTree = SimpleBehaviourTree.new(self)
var blackboard = {
	"hunger": 1000,
	"energy": 1000,
}

onready var navigation = NavigationManager.new(self)
onready var emote_text: Spatial = $EmoteText
onready var perception: Area = $Perception
onready var anim_state_machine: AnimationNodeStateMachinePlayback = $Model/AnimationTree["parameters/playback"]

func _ready():
	var _err = $AITime.connect("timeout", self , "ai_process")

func _physics_process(delta) -> void:
	navigation.process_navigation(delta)
	process_needs()

func process_needs() -> void:
	if blackboard.get("hunger") > 0:
		blackboard["hunger"] -= 1
	if blackboard.get("energy") > 0:
		blackboard["energy"] -= 1

func ai_process() -> void:
	var _status = behaviour_algorithm.update()

func emote(text: String) -> void:
	emote_text.text = text
