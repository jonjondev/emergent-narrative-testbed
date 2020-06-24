class_name NavigateToBehaviourTree
extends BehaviourTree

func _init(o, target_id).(o):
	root = \
	ActiveSelector.new([
		NearCondition.new(owner, target_id),
		NavigateAction.new(owner, target_id),
	])
