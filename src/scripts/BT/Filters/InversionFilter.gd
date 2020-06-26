class_name InversionFilter
extends Decorator

func _init(behaviour: Behaviour).(behaviour):
	.on_initialise()

func update() -> int:
	var status = child.tick()
	match(status):
		Status.FAILURE:
			return Status.SUCCESS
		Status.SUCCESS:
			return Status.FAILURE
	return Status.RUNNING

func on_terminate(status) -> void:
	.on_terminate(status)
