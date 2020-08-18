extends Slot
class_name InputSlot

var source

func get_slot_type(): #override
	return TYPES.IN

func _ready():
	set_meta("inp_idx", get_slot_idx())

func assign(val, source):
	self.source = source
	owner.state_inputs[get_meta("inp_idx")] = val
