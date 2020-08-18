extends Element

func _upd(): #override
	var a = state_inputs[0]
	if a:
		$Sprite.modulate = Color.yellow
	else:
		$Sprite.modulate = Color.white
