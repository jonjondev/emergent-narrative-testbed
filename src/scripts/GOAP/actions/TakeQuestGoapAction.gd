class_name TakeQuestGoapAction
extends GoapAction

var is_initialised = false
var is_complete = false

func _init(o).(o):
	preconditions = {
		ForestStates.StateConditions.KNOWS_QUESTGIVER: true,
	}
	effects = {
		ForestStates.StateConditions.HAS_QUEST: true,
	}

func setup() -> void:
	target = owner.blackboard.get("questgiver")[0]
	owner.emote("*quest-finding*")

func perform():
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
