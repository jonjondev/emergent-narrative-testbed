class_name RestGoapAction
extends GoapAction

func _init(o).(o):
	preconditions = {
		GoapStates.StateConditions.KNOWS_CHAIR: true,
	}
	effects = {
		GoapStates.StateConditions.IS_BORED: false,
	}

func setup() -> void:
	target = owner.blackboard.get("chair")[0]

func perform():
	if owner.navigation.is_near(target.translation):
		var interaction_data = target.interact(owner)
		owner.emote(interaction_data.name)
		return true
	return false
