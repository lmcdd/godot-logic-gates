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
	
	for connections in [inp_connections, out_connections]:
		for path_connection in connections:
			var connection = get_node_or_null(path_connection)
			if connection:
				connection.assign(v, self)
