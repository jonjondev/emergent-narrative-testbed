extends KinematicBody

var behaviour_algorithm: BehaviourTree = SimpleBehaviourTree.new(self)
var blackboard = {}

onready var navigation = NavigationManager.new(self)
onready var emote_text: Spatial = $"3DText"
onready var anim_state_machine: AnimationNodeStateMachinePlayback = $Model/AnimationTree["parameters/playback"]

func _ready():
	var _err = $AITime.connect("timeout", self , "ai_process")

func _physics_process(delta) -> void:
	navigation.process_navigation(delta)

func ai_process():
	var _status = behaviour_algorithm.update()

func emote(text: String) -> void:
	emote_text.text = text
