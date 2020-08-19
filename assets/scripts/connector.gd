extends Line2D
class_name Connector

var val = false setget set_val

func set_val(v):
	val = v
	if val:
		default_color = Color.green
	else:
		default_color = Color.white


var emitter setget set_emitter
var receiver setget set_receiver


func del():
	for slot in [emitter, receiver]:
		slot.inp_connections.erase(self.get_path())
		slot.out_connections.erase(self.get_path())
	assign(false, self)
	queue_free()
	
	
func set_emitter(v):
	emitter = v
	if emitter and receiver:
		assign(emitter.val, emitter)


func set_receiver(v):
	receiver = v
	if emitter and receiver:
		assign(emitter.val, emitter)


func auto_set_slot(slot):
	if slot.get_slot_type() == Slot.TYPES.IN: # IN - receiver
		receiver = slot
	else: #OUT - emitter
		emitter = slot
	if emitter and receiver:
		assign(emitter.val, emitter)
	

func assign(v, source):
	self.val = v
	#print(emitter.owner.name, '.', emitter.name, '->', name, ' ', v)
	if emitter and receiver:
		receiver.assign(v, self)


func _ready():
	name = "connector_" + str(get_parent().get_child_count())
	global_position = Vector2()
	joint_mode = Line2D.LINE_JOINT_ROUND
	width = 3
	if !val:
		default_color = Color.white
	points = PoolVector2Array([Vector2(), Vector2()])
