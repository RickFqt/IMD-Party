extends Node2D

# Variável global para armazenar dados
var Control_iniciado: bool = false

var player1 = {
	location = Vector2(0,0),
	index_location = 0,
	ob_coins = 0,
	opt_coins = 0,
	diplomas = 0
}

var player2 = {
	location = Vector2(0,0),
	index_location = 0,
	ob_coins = 0,
	opt_coins = 0,
	diplomas = 0
}

var semestre
var turno

func inicializar_control(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn, force := false):
	if Control_iniciado == false or force:
		
		
		player1.location = loc1
		player1.index_location = idx1
		player1.ob_coins = m_ob1
		player1.opt_coins = m_opt1
		player1.diplomas = dip1
		
		
		player2.location = loc2
		player2.index_location = idx2
		player2.ob_coins = m_ob2
		player2.opt_coins = m_opt2
		player1.diplomas = dip2
		
		
		semestre = sem
		turno = turn
		Control_iniciado = true
	
# Função para trocar de cena

func update_control(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn):
	inicializar_control(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn, true)


func trocar_cena(cena):
	# Carregar a nova cena
	get_tree().change_scene_to_file(cena)
