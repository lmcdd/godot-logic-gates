extends Node2D

var from_slot
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
				var connections = slot_node.connections["out"] + slot_node.connections["in"]
				if not(slot_node.get_slot_type() == Slot.TYPES.IN and connections.size() > 0):
					if !from_slot:
						from_slot = slot_node
						line = Connector.new()
						line.p_slot1 = slot_node
						$Connectors.add_child(line)
					else:
						if slot_node.get_slot_type() != from_slot.get_slot_type(): # In -> out , Out -> in
							var exists_connect = false #
							for connection in connections:
								exists_connect = from_slot in [connection.p_slot1, connection.p_slot2]
								if exists_connect:
									break
							if exists_connect == false:
								line.points = PoolVector2Array(
										[from_slot.global_position, slot_node.global_position]
								)
								line.p_slot2 = slot_node
								from_slot.connections["out"].append(line)
								slot_node.connections["in"].append(line)
								from_slot = null
								line = null
			elif event.button_index == BUTTON_RIGHT: #del connection
				var conn_groups = slot_node.connections.keys()
				for conn_group in conn_groups:
					for connection in slot_node.connections[conn_group]:
						if connection:
							if is_instance_valid(connection):
								for slot in [connection.p_slot1, connection.p_slot2]:
									var i = slot.connections[conn_group].find(connection)
									slot.connections[conn_group].remove(i)
									connection.queue_free()


func _on_Element_input_event(viewport, event, shape_idx, element_node):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			if target:
				target = null
			else:
				target = element_node


func _process(delta):
	if line:
		line.points = PoolVector2Array(
				[from_slot.global_position, get_global_mouse_position()]
		)
	if target:
		var mp = get_global_mouse_position()
		target.global_position = mp
		target.upd_pos_connections()
	
	if Input.is_action_just_pressed("ui_cancel"):
		if line:
			if is_instance_valid(line):
				line.queue_free()
				line = null
				from_slot = null
