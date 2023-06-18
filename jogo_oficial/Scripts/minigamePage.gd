extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel1.visible = false
	$Panel2.visible = false

func _startGame():
	$Panel1.visible = true
	$Panel2.visible = true

func _endGame():
	$Panel1.visible = false
	$Panel2.visible = false
