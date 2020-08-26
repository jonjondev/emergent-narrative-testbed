class_name GoapAgent

var goal_state = {
	GoapStates.StateConditions.ENEMY_ALIVE: false,
}

var actions = [
	AttackEnemyGoapAction,
	PickupSwordGoapAction,
]

func _init(owner):
	for i in range(actions.size()):
		actions[i] = actions[i].new(owner)
