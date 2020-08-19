extends Node2D

var from_slot
var cur_slot
var target
var line

onready var btns_add_element = $"CanvasLayer/Control/VBoxContainer"

func bind_element_signals(element):
	element.get_node("PickArea").connect(
			"input_event", self, "_on_Element_input_event", [element]
	)
	if element.has_node("Slots"):
		for slot in element.get_node("Slots").get_children():
			slot.connect(
					"input_event", self, "_on_Slot_input_event", [slot]
			)

func _ready():

	for element in $Elements.get_children():
		bind_element_signals(element)

	for btn_add_element in btns_add_element.get_children():
		btn_add_element.connect("pressed", self, "_on_btn_add_element_pressed", [btn_add_element])


func _on_btn_add_element_pressed(btn_add_element):
	var name_element = btn_add_element.name.split("_")[1].to_lower()
	var element = load("res://assets/scenes/" + name_element + ".tscn").instance()
	$"Elements".add_child(element)
	#element.global_position += get_viewport().size / 2
	bind_element_signals(element)
	target = element


func _on_Slot_input_event(viewport, event, shape_idx, slot_node):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_LEFT: #create connection
				_create_connection(slot_node)
			elif event.button_index == BUTTON_RIGHT: #del connection
				if not(from_slot):
					_del_connection(slot_node)


func _create_connection(slot_node):
	var conn_count = slot_node.out_connections.size() + slot_node.inp_connections.size()
	#print('cr|',slot_node.name,conn_count, slot_node.inp_connections, slot_node.out_connections)
	if not(slot_node.get_slot_type() == Slot.TYPES.IN and conn_count > 0):
		if !from_slot: # FROM
			from_slot = slot_node
			var l = load("res://assets/scenes/connector.tscn").instance()
			line = l
			line.auto_set_slot(slot_node)
			$Connectors.add_child(line)
		else: # TO
			if slot_node.get_slot_type() != from_slot.get_slot_type(): # In -> out , Out -> in
				var exists_connect = false #
				for connections in [slot_node.out_connections, slot_node.inp_connections]:
					for path_connection in connections:
						var connection = get_node_or_null(path_connection)
						if connection:
							exists_connect = from_slot in [connection.emitter, connection.receiver]
							if exists_connect:
								break
				if exists_connect == false:
					line.points = PoolVector2Array(
						[from_slot.global_position, slot_node.global_position]
					)
					from_slot.out_connections.append(line.get_path())
					slot_node.inp_connections.append(line.get_path())
					line.auto_set_slot(slot_node)
					from_slot = null
					line = null


func _del_connection(slot_node):
	for path_conn in slot_node.out_connections:
		var conn = get_node_or_null(path_conn)
		if conn:
			conn.call_deferred("del")

	for path_conn in slot_node.inp_connections:
		var conn = get_node_or_null(path_conn)
		if conn:
			conn.call_deferred("del")

	from_slot = null
	line = null


func _on_Element_input_event(viewport, event, shape_idx, element_node):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			if target:
				target = null
			else:
				target = element_node


func _process(delta):
	if cur_slot:
		print(cur_slot, cur_slot.connections)

	if line:
		line.points = PoolVector2Array(
				[from_slot.global_position, get_global_mouse_position()]
		)
		if Input.is_action_just_pressed("ui_cancel"): # ESC
			if line:
				if is_instance_valid(line):
					line.queue_free()
					line = null
					from_slot = null
	else:
		if target:
			var mp = get_global_mouse_position()
			target.global_position = mp
			target.call_deferred("upd_pos_connections")
			
	
		
		
