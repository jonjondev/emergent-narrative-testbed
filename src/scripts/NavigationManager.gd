class_name NavigationManager

const speed: float = 3.0
const gravity: Vector3 = Vector3(0, -10, 0)

var owner: KinematicBody
var velocity: Vector3 = Vector3.ZERO
var current_path: PoolVector3Array
var navigation: Navigation

var facing_target

func _init(o: KinematicBody, nav: Navigation) -> void:
	owner = o
	navigation = nav

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
	
	rotate_to(delta, owner.translation + move)
	
	if facing_target:
		rotate_to(delta, facing_target)
		if (owner.transform.basis.get_euler() - owner.transform.looking_at(facing_target, Vector3.UP).basis.get_euler()).length() < 0.1:
			facing_target = null
	
	owner.anim_state_machine.travel("idle" if move == Vector3.ZERO else "walk")
	
	velocity += gravity * delta
	velocity = owner.move_and_slide(velocity)

func rotate_to(delta, looking_at: Vector3) -> void:
	var initial_transform: Transform = owner.get_transform()
	var final_transform: Transform = Transform(initial_transform.basis, looking_at)
	if initial_transform != final_transform:
		var rotated_transform: Transform = initial_transform.looking_at(final_transform.origin, Vector3.UP)
		var rotated_quat: Quat = Quat(initial_transform.basis).slerp(rotated_transform.basis, delta*5)
		owner.set_transform(Transform(rotated_quat, initial_transform.origin))

func navigate_to(target_location: Vector3) -> void:
	current_path = navigation.get_simple_path(owner.global_transform.origin, target_location)

func stop_navigation():
	while not current_path.empty():
		current_path.remove(0)

func move_to_random_location() -> void:
	navigate_to(generate_random_location())

func generate_random_location() -> Vector3:
	var bounds: float = 9.0
	return navigation.get_closest_point(Vector3(rand_range(-bounds, bounds), 0, rand_range(-bounds, bounds)))

func is_near(target: Vector3, distance: float = 1.0) -> bool:
	return target and distance_to(target) < distance

func distance_to(target: Vector3) -> float:
	return owner.translation.distance_to(target)

func is_navigating() -> bool:
	return not current_path.empty()

func face_target(target: Vector3) -> void:
	facing_target = target

func get_final_destination() -> Vector3:
	var last_idx: int = current_path.size() - 1
	return current_path[last_idx] if last_idx >= 0 else owner.translation

func get_closest(potential_targets: Array) -> Object:
	var closest_target: Object
	var closest_distance: float
	for target in potential_targets:
		var distance: float = distance_to(target.translation)
		if not closest_target or distance < closest_distance:
			closest_target = target
			closest_distance = distance
	return closest_target
