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
		]),
		Sequence.new([
			GetVarAction.new(owner, "hunger", 0),
			EmoteAction.new(owner, "*hungry*"),
			NavigateAction.new(owner, "food"),
			InteractAction.new(owner, "food"),
		]),
		Sequence.new([
			EmoteAction.new(owner, "*social*"),
			NavigateAction.new(owner, "character", 2.0),
			AdvertiseInteractAction.new(owner),
			InteractAction.new(owner, "character"),
		]),
		ActiveSelector.new([
			Sequence.new([
				AdvertisingPartnerCondition.new(owner),
				NavigateAction.new(owner, "character", 2.0),
				AdvertiseInteractAction.new(owner),
				InteractAction.new(owner, "character"),
			]),
			Sequence.new([
				EmoteAction.new(owner, "*bored*"),
				NavigateAction.new(owner, "chair"),
				InteractAction.new(owner, "chair"),
			]),
		]),
	])
