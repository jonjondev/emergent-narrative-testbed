class_name AnimateAction
extends Action

var animation_name

func _init(o, animation).(o):
	animation_name = animation

func on_initialise() -> void:
	owner.animation.start_anim(animation_name)

func update() -> int:
	if owner.animation.anim_running:
		return Status.RUNNING
	return Status.SUCCESS
