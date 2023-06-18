extends Node

signal countdown_finished
signal endTime

var timeRemaining: int = 0
var countdownStep: float = 1
var countdownSeconds: int = 5

@onready var countdownLabel = $CountdownLabel
@onready var countdownTimer = $CountdownTimer
@onready var timerLabel = $TimerLabel
@onready var gameTimer = $GameTimer

func _ready():
	countdownTimer.timeout.connect(_onCountdownTick)
	gameTimer.timeout.connect(_onTimerCountdownTick)
	# Iniciar a contagem regressiva
	startCountdown()

# Função para a mensagem inicial
func startCountdown():
	countdownLabel.text = "Preparem-se!"
	countdownLabel.show()
	await get_tree().create_timer(2).timeout  # Aguarda 2 segundos antes de exibir a contagem regressiva
	countdownLabel.text = str(countdownSeconds)
	countdownTimer.start(countdownSeconds)
	countdownTimer.set_wait_time(countdownStep)
	countdownTimer.start()

# Função para a contagem regressiva
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
		print("Countdown finished")
		

# Função para o iniciar o timer do jogo
func _gameStart():
	timeRemaining = 29  # Defina o tempo máximo em segundos 
	timerLabel.text = str(timeRemaining)
	timerLabel.show()
	gameTimer.start(timeRemaining)
	gameTimer.set_wait_time(countdownStep)
	gameTimer.start()
	
# Função do timer do jogo
func _onTimerCountdownTick():
	timeRemaining -= 1
	timerLabel.text = str(timeRemaining)
	if timeRemaining <= 0:
		timerLabel.hide()
		gameTimer.stop()
		countdownLabel.text = "Fim!"
		countdownLabel.show()
		emit_signal("endTime")
		print("Time ended")
