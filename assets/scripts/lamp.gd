extends Element

export(Color) var OFF_COLOR = Color.white
export(Color) var ON_COLOR = Color.yellow

func _upd(): #override
	var a = state_inputs[0]
	if a:
		$Sprite.modulate = ON_COLOR
	else:
		$Sprite.modulate = OFF_COLOR


func _ready():
	$Sprite.modulate = OFF_COLOR
