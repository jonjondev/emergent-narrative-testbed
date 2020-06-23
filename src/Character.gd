extends KinematicBody

var speed: float = 0.05
var gravity: Vector3 = Vector3(0, -10, 0)
var velocity: Vector3 = Vector3.ZERO

onready var anim_state_machine: AnimationNodeStateMachinePlayback = $Model/AnimationTree["parameters/playback"]

func _physics_process(delta) -> void:
	var move: Vector3 = Vector3.ZERO
	if Input.is_action_pressed("ui_left"):
		move.x = -1
	if Input.is_action_pressed("ui_up"):
		move.z = -1
	if Input.is_action_pressed("ui_right"):
		move.x = 1
	if Input.is_action_pressed("ui_down"):
		move.z = 1
	
	translation = translation + move.normalized() * speed
	
	var initial_transform: Transform = get_transform()
	var final_transform: Transform = Transform(initial_transform.basis, translation + move)
	if initial_transform != final_transform:
		var rotated_transform: Transform = initial_transform.looking_at(final_transform.origin, Vector3.UP)
		var rotated_quat: Quat = Quat(initial_transform.basis).slerp(rotated_transform.basis, delta*5)
		set_transform(Transform(rotated_quat, initial_transform.origin))
	
	velocity += gravity * delta 
	velocity = move_and_slide(velocity)
	
	anim_state_machine.travel("idle" if move == Vector3.ZERO else "walk")
