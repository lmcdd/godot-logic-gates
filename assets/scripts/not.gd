extends Element

func _upd(): #override
	$"Slots/Out_1".emit(_operation())

func _operation(): #override
	var a = state_inputs[0]
	# ...
	return not(a)
