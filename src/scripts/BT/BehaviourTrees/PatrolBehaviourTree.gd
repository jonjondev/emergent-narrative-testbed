class_name PatrolBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	Sequence.new([
		Selector.new([
			GetVarAction.new(owner, "last_patrolled", "safe"),
			Sequence.new([
				NavigateToBehaviourTree.new(owner, "safe"),
				SetVarAction.new(owner, "last_patrolled", "safe"),
			]),
		]),
		Selector.new([
			GetVarAction.new(owner, "last_patrolled", "door"),
			Sequence.new([
				NavigateToBehaviourTree.new(owner, "door"),
				SetVarAction.new(owner, "last_patrolled", "door"),
			]),
		]),
	])
