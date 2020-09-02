class_name SleepGoapAction
extends GoapAction

var is_initialised = false
var is_complete = false

func _init(o).(o):
	preconditions = {
		GoapStates.StateConditions.KNOWS_BED: true,
	}
	effects = {
		GoapStates.StateConditions.IS_SLEEPY: false,
	}

func setup() -> void:
	target = owner.blackboard.get("bed")[0]
	owner.emote("*sleepy*")

func perform() -> bool:
	if not is_initialised and owner.navigation.is_near(target.translation, 1.5):
		var interaction_data = target.interact(owner)
		owner.emote(interaction_data.name)
		owner.get_tree().create_timer(interaction_data.length).connect("timeout", self, "complete")
		is_initialised = true
	elif is_complete:
		reset()
		return true
	return false

func complete() -> void:
	is_complete = true

func reset() -> void:
	owner.emote("")
	is_complete = false
	is_initialised = false
