extends KinematicBody

export (String) var character_name

var blackboard = {
	"hunger": 500,
	"energy": 0,
}

var behaviour_algorithm: StateMachine = GoapStateMachine.new(self)

onready var navigation = NavigationManager.new(self, $"../Navigation")
onready var emote_text: Spatial = $EmoteText
onready var perception: Area = $Perception
onready var anim_state_machine: AnimationNodeStateMachinePlayback = $Model/AnimationTree["parameters/playback"]

func _ready():
	var _err = $AITime.connect("timeout", self , "ai_process")
	_err = perception.connect("area_entered", self, "percieve")
	behaviour_algorithm.on_enter()

func _physics_process(delta) -> void:
	navigation.process_navigation(delta)
	process_needs()

func process_needs() -> void:
	if blackboard.get("hunger") > 0:
		blackboard["hunger"] -= 1
	if blackboard.get("energy") > 0:
		blackboard["energy"] -= 1

func ai_process() -> void:
	behaviour_algorithm.on_update()

func emote(text: String) -> void:
	emote_text.text = text + "\n" + character_name

func percieve(area) -> void:
	if area is SmartObject and area.self_value != self:
		for group in area.get_groups():
			if blackboard.get(group):
				blackboard[group].append(area)
			else:
				blackboard[group] = [area]
