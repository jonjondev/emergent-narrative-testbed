class_name PauseAction
extends Action

var pause_time
var is_complete

func _init(o, time).(o):
	pause_time = time

func on_initialise() -> void:
	owner.get_tree().create_timer(pause_time).connect("timeout", self, "complete")
	.on_initialise()

func update() -> int:
	if is_complete:
		return Status.SUCCESS
	return Status.RUNNING

func on_terminate(status) -> void:
	is_complete = false
	.on_terminate(status)

func complete() -> void:
	if current_status == Status.RUNNING:
		is_complete = true
