extends Node

signal toggle_pause(status)

var paused setget _set_paused

func _set_paused(val):
	paused = val
	emit_signal("toggle_pause", paused)
