extends Node2D

# "Classe" que armazena variáveis globais do jogo

var player1 : Node2D # Player 1
var player2 : Node2D # Player 2
var player1Dir = "res://jogo_oficial/Players/boy1.tscn" # Animação player 1
var player2Dir = "res://jogo_oficial/Players/girl1.tscn" # Animaçõa player 2
var locations = [] # Indica localização dos tiles
var rodada : int # Indica a rodada atual da partida
var semestre : int # Indica o semestre atual da partida
var loc_inicializado = false # Indica se as localizações ja foram inicializadas
var players_inicializados = false # Indica se os players ja foram inicializados (junto com a partida)
var star_price = {ob = 1, opt = 3} # Indica o preço do diploma
var star_location = {loc = Vector2(0,0), index = 0} # Indica a localização do diploma

# Infos do player1
var infoPlayer1 = {
	location = Vector2(0,0),
	index_location = 0,
	ob_coins = 0,
	opt_coins = 0,
	diplomas = 0,
}

# Indos do player2
var infoPlayer2 = {
	location = Vector2(0,0),
	index_location = 0,
	ob_coins = 0,
	opt_coins = 0,
	diplomas = 0,
}

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

# Inicializa as localizações dos tiles
func inicializar_locations(loc):
	locations = loc.duplicate(true)
	loc_inicializado = true

# Inicializa a posição atual do diploma
func inicializar_star(n):
	star_location.loc = locations[n].loc
	star_location.index = n
	#locations[n].special = true

# Atualiza a posição da estrela
func atualizar_star(new_n):
	#locations[star_location.index].special = false
	inicializar_star(new_n)

# Inicializa as informações dos players e da partida
func inicializar_players(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn, force := false):
	if !players_inicializados or force:
		
		# Atualiza player1
		infoPlayer1.location = loc1
		infoPlayer1.index_location = idx1
		infoPlayer1.ob_coins = m_ob1
		infoPlayer1.opt_coins = m_opt1
		infoPlayer1.diplomas = dip1
		
		# Atualiza player2
		infoPlayer2.location = loc2
		infoPlayer2.index_location = idx2
		infoPlayer2.ob_coins = m_ob2
		infoPlayer2.opt_coins = m_opt2
		infoPlayer2.diplomas = dip2
		
		# Atualiza o valor dos semestres e rodadas
		semestre = sem
		rodada = turn
		players_inicializados = true

# Atualiza as informações dos players e da partida
func update_global(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn):
	inicializar_players(loc1, idx1, m_ob1, m_opt1, dip1, loc2, idx2, m_ob2, m_opt2, dip2, sem, turn, true)

# Troca para a cena informada
func trocar_cena(cena):
	# Carregar a nova cena
	get_tree().change_scene_to_file(cena)
