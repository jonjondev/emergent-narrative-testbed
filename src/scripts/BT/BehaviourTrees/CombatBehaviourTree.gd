class_name CombatBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	Sequence.new([
		NavigateToBehaviourTree.new(owner, "enemy"),
		AttackAction.new(owner, "enemy"),
	])
