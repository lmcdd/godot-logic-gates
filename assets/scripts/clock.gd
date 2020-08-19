tool
extends Element

export(float) var timeout = 0.5 setget _set_timeout
var state = false


func _set_timeout(val):
	timeout = val
	if is_instance_valid($Timer):
		$Timer.wait_time = val


func _ready():
	G.connect("toggle_pause", self, "_on_toggle_pause")
	if G.paused:
		$Timer.stop()
	else:
		$Timer.start()


func _on_toggle_pause(paused):
	if paused:
		$Timer.stop()
	else:
		$Timer.start()


func _on_Timer_timeout():
	state = !state
	if state:
		$Sprite.self_modulate = Color.green
	else:
		$Sprite.self_modulate = Color.white
	$"Slots/Out_1".emit(state)
	
