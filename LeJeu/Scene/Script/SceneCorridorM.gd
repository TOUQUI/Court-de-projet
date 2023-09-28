extends Node2D

var joueur_node
var provenance 

func _ready():
	joueur_node = get_node("Joueur")
	provenance = joueur_node.derniere_emplacement
	if provenance == "G":
		$Joueur.position = Vector2(118,325)
	elif provenance == "D":
		$Joueur.position = Vector2(1005,331)



func _on_c_mvers_cg_body_entered(body):
	find_child("Joueur").derniere_emplacement = "M"
