extends Element

func _upd(): #override
	$"Slots/Out_1".emit(_operation())

func _operation(): #override
	var a = state_inputs[0]
	var b = state_inputs[1]
	return a and b
	# тут можно было сделать на большее кол-во входных аргументов, 
	# но я пока ограничил и захардкодил на 2
	
