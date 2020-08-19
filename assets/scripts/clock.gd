extends Element

export(float) var sec = 0.5

var state = false

func _upd(): #override
	state = !state
	$"Slots/Out_1".emit(state)
	yield(get_tree().create_timer(sec), "timeout")
	_upd()

func _ready():
	_upd()
