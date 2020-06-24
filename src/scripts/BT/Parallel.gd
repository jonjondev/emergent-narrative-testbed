class_name Parallel
extends Composite

enum Policy {REQ_ONE, REQ_ALL}

var success_policy
var failure_policy

func _init(success: int, failure: int, behaviours: Array).(behaviours):
	success_policy = success
	failure_policy = failure

func update() -> int:
	var success_count = 0
	var failure_count = 0
	
	for child in children:
		var status = child.tick()
		match(status):
			Status.SUCCESS:
				success_count += 1
				if success_policy == Policy.REQ_ONE:
					return Status.SUCCESS
			Status.FAILURE:
				failure_count += 1
				if failure_policy == Policy.REQ_ONE:
					return Status.FAILURE
		
	if failure_policy == Policy.REQ_ALL and failure_count >= children.size():
		return Status.FAILURE
	elif success_policy == Policy.REQ_ALL and success_count >= children.size():
		return Status.SUCCESS
	return Status.RUNNING
