extends Node2D

var joueur_node
var provenance 
var joeur_ascenseur = false
var joueur_porte = false

func _ready():
	joueur_node = get_node("Joueur")
	provenance = joueur_node.derniere_emplacement
	if provenance == "G":
		$Joueur.position = Vector2(118,325)
	elif provenance == "D":
		$Joueur.position = Vector2(1005,331)
	elif provenance == "Exterieur":
		$Joueur.position = Vector2(560,130)

func _input(event):
	if event.is_action_pressed("interaction") && (joeur_ascenseur or joueur_porte):
		$MenuDeplacement.visible = true

func _on_c_mvers_cg_body_entered(body):
	find_child("Joueur").derniere_emplacement = "M"


func _on_c_mvers_nimpote_body_entered(body):
	joeur_ascenseur = true
	$CMAscenseur/F.visible = true

func _on_cm_ascenseur_body_exited(body):
	joeur_ascenseur = false
	$CMAscenseur/F.visible = false
	$MenuDeplacement.visible = false


func _on_cm_porte_body_entered(body):
	joueur_porte = true
	$CMPorte/F.visible = true


func _on_cm_porte_body_exited(body):
	joueur_porte = false
	$CMPorte/F.visible = false
	$MenuDeplacement.visible = false



func _on_btn_chambre_pressed():
	get_tree().change_scene_to_file("res://Scene/SceneMaison.tscn")


func _on_btn_cafeteria_pressed():
	get_tree().change_scene_to_file("res://Scene/SceneCaféteria.tscn")


func _on_btn_retour_pressed():
	$MenuDeplacement.visible = false
