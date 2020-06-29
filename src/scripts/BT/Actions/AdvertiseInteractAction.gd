class_name AdvertiseInteractAction
extends Action

var has_failed

func _init(o).(o):
	pass

func on_initialise() -> void:
	owner.blackboard["advertising_state"] = true
	owner.emote("*advertising*")
	owner.get_tree().create_timer(2.0).connect("timeout", self, "fail")
	.on_initialise()

func update() -> int:
	if has_failed:
		return Status.FAILURE
	else:
		if owner.blackboard.get("character").self_value.blackboard.get("advertising_state"):
			return Status.SUCCESS
	return Status.RUNNING

func on_terminate(status) -> void:
	has_failed = false
	.on_terminate(status)

func fail() -> void:
	if current_status == Status.RUNNING:
		has_failed = true
