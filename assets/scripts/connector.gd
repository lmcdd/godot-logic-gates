extends Line2D
class_name Connector

var val = false setget set_val

func set_val(v):
	val = v
	if val:
		default_color = Color.green
	else:
		default_color = Color.white


var p_slot1 setget set_slot1
var p_slot2 setget set_slot2

func set_slot1(val):
	p_slot1 = val
	set_slot(val)
	
func set_slot2(val):
	p_slot2 = val
	set_slot(val)

func set_slot(val):
	if p_slot1 and p_slot2:
		if p_slot2.get_slot_type() == Slot.TYPES.IN:
			assign(p_slot1.val, p_slot1)
		else:
			assign(p_slot2.val, p_slot2)
		

func assign(v, source):
	self.val = v
	#print(emitter.owner.name, '.', emitter.name, '->', name, ' ', v)
	if p_slot1 and p_slot2:
		for p_slot in [p_slot1, p_slot2]:
			if p_slot.get_slot_type() == Slot.TYPES.IN:
				p_slot.assign(v, self)


func _ready():
	name = "connector_" + str(get_parent().get_child_count())
	global_position = Vector2()
	joint_mode = Line2D.LINE_JOINT_ROUND
	width = 3
	if !val:
		default_color = Color.white
	points = PoolVector2Array([Vector2(), Vector2()])
