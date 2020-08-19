extends Button


func _ready():
	pass # Replace with function body.


func _on_Btn_Pause_toggled(button_pressed):
	G.paused = button_pressed
	if button_pressed:
		icon = load("res://assets/images/play.png")
	else:
		icon = load("res://assets/images/pause.png")
	
		

