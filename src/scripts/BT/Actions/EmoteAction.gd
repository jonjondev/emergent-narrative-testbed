class_name EmoteAction
extends Action

var emote_text

func _init(o, emote).(o):
	emote_text = emote

func on_initialise() -> void:
	owner.emote(emote_text)

func update() -> int:
	return Status.SUCCESS
