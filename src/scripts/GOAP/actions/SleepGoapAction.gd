class_name SleepGoapAction
extends GoapAction

func _init(o).(o):
	preconditions = {
		GoapStates.StateConditions.KNOWS_BED: true,
	}
	effects = {
		GoapStates.StateConditions.IS_SLEEPY: false,
	}

func setup() -> void:
	target = owner.blackboard.get("bed")[0]

func perform() -> bool:
	if owner.navigation.is_near(target.translation):
		var interaction_data = target.interact(owner)
		owner.emote(interaction_data.name)
		return true
	return false
