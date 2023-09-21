extends StaticBody2D

var joueur_node
var provenance 

func _ready():
	joueur_node = get_node("Joueur")
	provenance = joueur_node.derniere_emplacement
	if provenance == "QG":
		$Joueur.position = Vector2(7, -134)
	elif provenance == "M":
		$Joueur.position = Vector2(221, -41)


func _on_c_gvers_cm_body_entered(body):
	find_child("Joueur").derniere_emplacement = "G"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")
