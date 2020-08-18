extends Slot
class_name OutputSlot

var val = false setget ,get_val

func get_val():
	return owner._operation()

func get_slot_type(): #override
	return TYPES.OUT

func emit(v):
	val = v
	#print(owner.name, ' ', name,' ', v)
	for slot_conn in connections["out"] + connections["in"]:
		slot_conn.assign(v, self)
