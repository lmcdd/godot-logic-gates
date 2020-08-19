extends Area2D
class_name Slot

enum TYPES {NONE, IN, OUT}

var out_connections = []
var inp_connections = [] 



func get_slot_type():
	return TYPES.NONE

func get_slot_idx():
	return int(name.split("_")[1]) - 1

func assign(v, source):
	pass
