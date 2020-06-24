class_name SimpleBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	Selector.new([
		Sequence.new([
			GetVarAction.new(owner, "eaten", false),
			VisibleCondition.new(owner, "food"),
			EmoteAction.new(owner, "*hungry*"),
			NavigateAction.new(owner, "food"),
			EmoteAction.new(owner, "*eating*"),
			SetVarAction.new(owner, "eaten", true),
		]),
		Sequence.new([
			EmoteAction.new(owner, "*sleepy*"),
			NavigateAction.new(owner, "bed"),
			EmoteAction.new(owner, "*sleeping*"),
			SetVarAction.new(owner, "eaten", false),
		]),
	])
