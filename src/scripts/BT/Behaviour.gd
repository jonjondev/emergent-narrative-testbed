class_name Behaviour

enum Status {DEFAULT, RUNNING, SUCCESS, FAILURE}

var current_status = Status.DEFAULT

func on_initialise() -> void:
	pass

func update() -> int:
	return Status.FAILURE

func on_terminate(status) -> void:
	current_status = status

func tick() -> int:
	if current_status != Status.RUNNING:
		on_initialise()
	current_status = update()
	if current_status != Status.RUNNING:
		on_terminate(current_status)
	return current_status
