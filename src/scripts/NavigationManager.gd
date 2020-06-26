class_name NavigationManager

const speed: float = 3.0
const gravity: Vector3 = Vector3(0, -10, 0)

var owner: KinematicBody
var velocity: Vector3 = Vector3.ZERO
var current_path: PoolVector3Array
var navigation: Navigation

func _init(o: KinematicBody) -> void:
	owner = o
	navigation = owner.get_node("../Navigation")

func process_navigation(delta: float) -> void:
	var move: Vector3 = Vector3.ZERO
	if is_navigating():
		move = current_path[0] - owner.global_transform.origin
		move.y = 0
		if move.length() < 0.1:
			current_path.remove(0)
		else:
			move = move.normalized() * speed
		var _slide = owner.move_and_slide(move)
	
	var initial_transform: Transform = owner.get_transform()
	var final_transform: Transform = Transform(initial_transform.basis, owner.translation + move)
	if initial_transform != final_transform:
		var rotated_transform: Transform = initial_transform.looking_at(final_transform.origin, Vector3.UP)
		var rotated_quat: Quat = Quat(initial_transform.basis).slerp(rotated_transform.basis, delta*5)
		owner.set_transform(Transform(rotated_quat, initial_transform.origin))
	
	owner.anim_state_machine.travel("idle" if move == Vector3.ZERO else "walk")
	
	velocity += gravity * delta 
	velocity = owner.move_and_slide(velocity)

func navigate_to(target_location: Vector3) -> void:
	current_path = navigation.get_simple_path(owner.global_transform.origin, target_location)

func move_to_random_location() -> void:
	var bounds: float = 4.0
	navigate_to(Vector3(rand_range(-bounds, bounds), 0, rand_range(-bounds, bounds)))

func is_near(target: Vector3) -> bool:
	return target and distance_to(target) < 1.0

func distance_to(target: Vector3) -> float:
	return owner.translation.distance_to(target)

func is_navigating() -> bool:
	return not current_path.empty()
