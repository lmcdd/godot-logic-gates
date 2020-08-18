extends Element

var state = false

func _upd(): #override
	state = !state
	$"Slots/Out_1".emit(state)
	yield(get_tree().create_timer(0.5), "timeout")
	_upd()

func _ready():
	_upd()
