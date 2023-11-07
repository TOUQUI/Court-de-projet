extends Node2D

var joueurDirection
var provenance
var joueur_node
var joueurDansZone4823 = false
var joueurDansZoneBossDeux = false
var nodeInterface
var joueur = preload("res://Joueur/joueur.gd")
var quete
var boite = preload("res://UI/boite_de_textes.tscn")


func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/SceneCorridorD.tscn"
	joueur_node = get_node("Joueur")
	provenance = joueur_node.derniere_emplacement
	if provenance == "4923":
		$Joueur.position = Vector2(-317,-267)
	elif provenance == "BureauProf":
		$Joueur.position = Vector2(462,-81)
	elif provenance == "M":
		$Joueur.position = Vector2(-453,-90)
	elif provenance == "Blibli":
		$Joueur.position = Vector2(380,-271)
	joueur_node.derniere_emplacement = "D"


func _input(event):
	if event.is_action_pressed("interaction"):
		if joueurDansZone4823:
			joueurDirection = "res://Scene/scene_4823.tscn"
			joueur.derniere_emplacement = "4823"
			$Porte4823/AnimationPorte4823.play("ouverture")
			$AttentePorte.start()
		elif joueurDansZoneBossDeux:
			get_tree().change_scene_to_file("res://Scene/scene_bibliotheque.tscn")


func _on_area_2d_body_entered(body):
	find_child("Joueur").derniere_emplacement = "D"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


func _on_porte_4823_body_entered(body):
	joueurDansZone4823 = true
	$Porte4823/F.visible = true


func _on_porte_4823_body_exited(body):
	joueurDansZone4823 = false
	$Porte4823/F.visible = false


func _on_attente_porte_timeout():
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false
	get_tree().change_scene_to_file(joueurDirection)


func _on_porte_boss_un_body_entered(body):
	joueurDansZoneBossDeux = true
	$PorteBossDeux/F.visible = true


func _on_porte_boss_un_body_exited(body):
	joueurDansZoneBossDeux = false
	$PorteBossDeux/F.visible = false


func _on_vers_bureau_prof_body_entered(body):
	joueur.derniere_emplacement = "BureauProf"
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false
	get_tree().change_scene_to_file("res://Scene/sceneBureauProf.tscn")
