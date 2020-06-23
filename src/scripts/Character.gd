extends KinematicBody

var speed: float = 3.0
var gravity: Vector3 = Vector3(0, -10, 0)
var velocity: Vector3 = Vector3.ZERO

var thinking: bool
var current_path: PoolVector3Array

onready var anim_state_machine: AnimationNodeStateMachinePlayback = $Model/AnimationTree["parameters/playback"]
onready var navigation: Navigation  = $"../Navigation"

func _physics_process(delta) -> void:
	if not thinking:
		navigate(delta)
	velocity += gravity * delta 
	velocity = move_and_slide(velocity)

func navigate(delta) -> void:
	var move: Vector3 = Vector3.ZERO
	if current_path.size() > 0:
		move = current_path[0] - global_transform.origin
		move.y = 0
		if move.length() < 0.1:
			current_path.remove(0)
		else:
			move = move.normalized() * speed
	else:
		thinking = true
		get_tree().create_timer(rand_range(0.5, 2.0)).connect("timeout", self, "move_to_random_location")
	move_and_slide(move)
	
	var initial_transform: Transform = get_transform()
	var final_transform: Transform = Transform(initial_transform.basis, translation + move)
	if initial_transform != final_transform:
		var rotated_transform: Transform = initial_transform.looking_at(final_transform.origin, Vector3.UP)
		var rotated_quat: Quat = Quat(initial_transform.basis).slerp(rotated_transform.basis, delta*5)
		set_transform(Transform(rotated_quat, initial_transform.origin))
	
	anim_state_machine.travel("idle" if move == Vector3.ZERO else "walk")

func move_to_random_location():
	thinking = false
	var bounds: int = 4.0
	set_path_to(Vector3(rand_range(-bounds, bounds), 0, rand_range(-bounds, bounds)))

func set_path_to(target_location):
	current_path = navigation.get_simple_path(global_transform.origin, target_location)
