extends Node

var countdownLabel: Label
var countdownTimer: Timer
var countdownStep: float = 1
var countdownSeconds: int = 5

func _ready():
	# Referenciar a Label e o Timer
	countdownLabel = $CountdownLabel
	countdownTimer = $CountdownTimer
	countdownTimer.timeout.connect(_onCountdownTick)

	# Iniciar a contagem regressiva
	startCountdown()

func startCountdown():
	countdownLabel.text = "Preparem-se!"
	countdownLabel.show()
	await get_tree().create_timer(2).timeout  # Aguarda 2 segundos antes de exibir a contagem regressiva
	countdownLabel.text = str(countdownSeconds)
	countdownTimer.start(countdownSeconds)
	countdownTimer.set_wait_time(countdownStep)
	countdownTimer.start()
	

func _onCountdownTick():
	countdownSeconds -= 1
	countdownLabel.text = str(countdownSeconds)
	if countdownSeconds <= 0:
		countdownLabel.text = "Começem!"	
		await get_tree().create_timer(1).timeout	
		countdownLabel.hide()
		countdownLabel.text = ""
		countdownTimer.stop()
		emit_signal("countdown_finished")
