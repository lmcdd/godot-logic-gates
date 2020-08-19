extends Element


func _upd(): #override
	$"Slots/Out_1".emit(_operation())


func _operation(): #override
	var a = state_inputs[0]
	var b = state_inputs[1]
	# ...
	return bool(int(a) ^ int(b))
