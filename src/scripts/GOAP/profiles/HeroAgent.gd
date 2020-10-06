class_name HeroAgent
extends GoapAgent

func _init(owner):
	states = ForestStates
	goal_state = {
		ForestStates.StateConditions.HAS_TREASURE: true,
	}
	actions = [
		TakeQuestAction,
		PerformQuestAction,
		PickupTreasureAction,
		SearchAction,
	]
	.setup(owner)
