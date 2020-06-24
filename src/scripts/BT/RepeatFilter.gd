class_name RepeatFilter
extends Decorator

var repeat_value
var repeated = 0

func _init(value: int, behaviour: Behaviour).(behaviour):
	repeat_value = value
	.on_initialise()

func update() -> int:
	if repeated >= repeat_value:
		return Status.SUCCESS
	var status = child.tick()
	match(status):
		Status.RUNNING:
			pass
		Status.FAILURE:
			return Status.FAILURE
		Status.SUCCESS:
			repeated += 1
	return Status.RUNNING

func on_terminate(status) -> void:
	if status == Status.FAILURE:
		repeated = 0
	.on_terminate(status)
