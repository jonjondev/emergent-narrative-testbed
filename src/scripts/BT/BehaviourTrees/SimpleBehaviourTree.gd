class_name SimpleBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	Selector.new([
		Sequence.new([
			GetVarAction.new(owner, "energy", 0),
			EmoteAction.new(owner, "*sleepy*"),
			NavigateAction.new(owner, "bed"),
			EmoteAction.new(owner, "*sleeping*"),
			PauseAction.new(owner, 1.0),
			SetVarAction.new(owner, "energy", 1000),
		]),
		Sequence.new([
			GetVarAction.new(owner, "hunger", 0),
			EmoteAction.new(owner, "*hungry*"),
			NavigateAction.new(owner, "food"),
			EmoteAction.new(owner, "*eating*"),
			PauseAction.new(owner, 1.0),
			SetVarAction.new(owner, "hunger", 1000),
		]),
		Sequence.new([
			EmoteAction.new(owner, "*social*"),
			NavigateAction.new(owner, "character"),
			InteractAction.new(owner, "character", "*talking*"),
		]),
		Sequence.new([
			EmoteAction.new(owner, "*tired*"),
			NavigateAction.new(owner, "chair"),
			EmoteAction.new(owner, "*sitting*"),
			PauseAction.new(owner, 1.0),
		]),
	])
