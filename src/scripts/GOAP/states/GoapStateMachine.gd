class_name GoapStateMachine
extends StateMachine

func _init(o).(o):
	current_state = PlanningState
	transition_state_map = {
		PlanningState: [
			[GeneratedPlanTransition, ActionState],
		],
		ActionState: [
			[NavigationRequiredTransition, NavigationState],
			[CompletedActionsTransition, PlanningState],
		],
		NavigationState: [
			[NavigationCompletedTransition, ActionState],
		],
	}
	.setup()
