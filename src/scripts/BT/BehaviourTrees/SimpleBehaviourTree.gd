class_name SimpleBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	Selector.new([
		Sequence.new([
			GetVarAction.new(owner, "energy", 0),
			EmoteAction.new(owner, "*sleepy*"),
			NavigateAction.new(owner, "bed"),
			InteractAction.new(owner, "bed"),
			EmoteAction.new(owner, "*sleeping*"),
		]),
		Sequence.new([
			GetVarAction.new(owner, "hunger", 0),
			EmoteAction.new(owner, "*hungry*"),
			NavigateAction.new(owner, "food"),
			InteractAction.new(owner, "food"),
			EmoteAction.new(owner, "*eating*"),
		]),
		Sequence.new([
			EmoteAction.new(owner, "*social*"),
			NavigateAction.new(owner, "character"),
			AdvertiseInteractAction.new(owner),
			InteractAction.new(owner, "character"),
		]),
		Sequence.new([
			EmoteAction.new(owner, "*tired*"),
			NavigateAction.new(owner, "chair"),
			EmoteAction.new(owner, "*sitting*"),
		]),
	])
