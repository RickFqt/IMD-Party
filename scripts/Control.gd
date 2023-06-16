extends Node2D

# Variáveis globais para armazenar dados
var Control_iniciado: bool = false

# TODO: inicializar as animações dos players direito
var player1 = {
	location = Vector2(0,0),
	index_location = 0,
	ob_coins = 0,
	opt_coins = 0,
	diplomas = 0,
	animation = 0
}

var player2 = {
	location = Vector2(0,0),
	index_location = 0,
	ob_coins = 0,
	opt_coins = 0,
	diplomas = 0,
	animation = 1
}

var semestre
var turno

func inicializar_control(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn, force := false):
	if Control_iniciado == false or force:
		
		# Atualiza player1
		player1.location = loc1
		player1.index_location = idx1
		player1.ob_coins = m_ob1
		player1.opt_coins = m_opt1
		player1.diplomas = dip1
		
		# Atualiza player2
		player2.location = loc2
		player2.index_location = idx2
		player2.ob_coins = m_ob2
		player2.opt_coins = m_opt2
		player1.diplomas = dip2
		
		# Atualiza o valor dos semestres e turnos
		semestre = sem
		turno = turn
		Control_iniciado = true

func update_control(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn):
	inicializar_control(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn, true)


func trocar_cena(cena):
	# Carregar a nova cena
	get_tree().change_scene_to_file(cena)
