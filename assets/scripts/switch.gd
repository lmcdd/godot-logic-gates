tool
extends Element

export(bool) var state = false setget set_state


func _operation():
	return state


func set_state(val):
	state = val
	if state:
		$Sprite.texture = load("res://assets/images/switch_on.png")
	else:
		$Sprite.texture = load("res://assets/images/elements/switch.png")
	$"Slots/Out_1".emit(state)


func _toggle(): #override
	self.state = !state
