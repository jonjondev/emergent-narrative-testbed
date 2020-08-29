class_name EatGoapAction
extends GoapAction

var is_initialised = false
var is_complete = false

func _init(o).(o):
	preconditions = {
		GoapStates.StateConditions.KNOWS_FOOD: true,
	}
	effects = {
		GoapStates.StateConditions.IS_HUNGRY: false,
	}

func setup() -> void:
	target = owner.blackboard.get("food")[0]

func perform():
	owner.emote("*hungry*")
	if owner.navigation.is_near(target.translation, 1.5):
		if not is_initialised:
			var interaction_data = target.interact(owner)
			owner.emote(interaction_data.name)
			owner.get_tree().create_timer(interaction_data.length).connect("timeout", self, "complete")
			is_initialised = true
		elif is_complete:
			owner.emote("")
			is_initialised = false
			is_complete = false
			return true
	return false

func complete() -> void:
	is_complete = true
