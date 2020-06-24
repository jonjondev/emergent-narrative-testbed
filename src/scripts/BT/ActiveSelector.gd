class_name ActiveSelector
extends Selector

func _init(behaviours: Array).(behaviours):
	pass

func update() -> int:
	var previous_idx = current_child_idx
	.on_initialise()
	var status = .update()
	if previous_idx != children.size() and current_child_idx != previous_idx:
		children[previous_idx].on_terminate(Status.FAILURE)
	return status
