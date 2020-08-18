extends Node2D
class_name Element

var state_inputs = [] setget set_state_input

func upd_pos_connections():
	for slot in $"Slots".get_children():
		for slot_conn in slot.connections["out"]:
			slot_conn.points[0] = slot.global_position
		for slot_conn in slot.connections["in"]:
			slot_conn.points[1] = slot.global_position
			

func _upd(): #early binding for override
	pass

func _toggle(): #early binding for override
	pass

func _operation(): #early binding for override
	return false

func set_state_input(val):
	state_inputs = val
	_upd()

func _ready():
	add_to_group(name.split("_")[0])
	var i = 0
	for slot in $"Slots".get_children():
		if slot.name.begins_with("In"):
			state_inputs.append(false)
			i += 1


func _on_PickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_RIGHT:
			_toggle()
		#elif event.pressed and event.button_index == BUTTON_LEFT:
		#	_pick()

	
#func _pick(): #early binding for override
#	pass
	
