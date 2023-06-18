extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel1.visible = false
	$Panel2.visible = false
	$Panel1.set_process_input(false)
	$Panel2.set_process_input(false)
	

func _startGame():
	$Panel1.visible = true
	$Panel2.visible = true
	$Panel1.set_process_input(true)
	$Panel2.set_process_input(true)

func _endGame():
	$Panel1.visible = false
	$Panel2.visible = false
	$Panel1.set_process_input(false)
	$Panel2.set_process_input(false)
