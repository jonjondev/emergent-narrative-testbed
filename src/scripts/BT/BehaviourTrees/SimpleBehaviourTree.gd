class_name SimpleBehaviourTree
extends BehaviourTree

func _init(o).(o):
	root = \
	Sequence.new([
		EmoteAction.new(owner, "*hungry*"),
		NavigateAction.new(owner, "food"),
		EmoteAction.new(owner, "*eating*"),
		PauseAction.new(owner, 1.0),
		EmoteAction.new(owner, "*sleepy*"),
		NavigateAction.new(owner, "bed"),
		EmoteAction.new(owner, "*sleeping*"),
		PauseAction.new(owner, 1.0),
	])
