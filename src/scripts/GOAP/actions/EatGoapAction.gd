class_name EatGoapAction
extends GoapAction

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
	print("performing")
	if owner.navigation.is_near(target.translation, 2.0):
		print("nearby")
		var interaction_data = target.interact(owner)
		owner.emote(interaction_data.name)
		#owner.get_tree().create_timer(interaction_data.length).connect("timeout", self, "complete")
		return true
	return false

func complete() -> void:
	is_complete = true
