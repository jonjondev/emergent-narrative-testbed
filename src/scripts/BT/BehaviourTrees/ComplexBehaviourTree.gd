class_name ComplexBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	ActiveSelector.new([
		VisiblePrecondition.new(owner, "enemy", 
			Sequence.new([
				AnimateAction.new(owner, "alerted"),
				SetVarAction.new(owner, "last_patrolled", "door"),
				RepeatFilter.new(2,
					PatrolBehaviourTree.new(owner)
				),
				Parallel.new(Parallel.Policy.REQ_ALL, Parallel.Policy.REQ_ONE, [
					AnimateAction.new(owner, "alerted"),
					CombatBehaviourTree.new(owner),
				]),
			])
		),
		PatrolBehaviourTree.new(owner),
	])
