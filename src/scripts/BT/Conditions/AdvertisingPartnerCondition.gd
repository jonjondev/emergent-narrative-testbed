class_name AdvertisingPartnerCondition
extends Condition

func _init(o).(o):
	pass

func update() -> int:
	for potential_target in owner.perception.get_overlapping_areas():
		if potential_target.is_in_group("character") and potential_target.self_value != owner and potential_target.self_value.blackboard.get("advertising_state"):
			return Status.SUCCESS
	return Status.FAILURE
