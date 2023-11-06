extends Node2D

var sceneACharcher
var nodeJoueur
var nodeInterface

func _ready():
	nodeJoueur = find_child("Joueur")
	nodeJoueur.derniere_emplacement = "Menu"
	nodeInterface = nodeJoueur.find_child("Joueur_interface")
	nodeInterface.visible = false


func _on_jouer_pressed():
	$ChargementIcon.visible = true
	sceneACharcher = SingletonsDonnees.dictionaireDesDonnees["DataSession"].emplacementSauvegarde
	get_tree().change_scene_to_file(sceneACharcher)


func _on_paramètres_pressed():
	pass # Replace with function body.
