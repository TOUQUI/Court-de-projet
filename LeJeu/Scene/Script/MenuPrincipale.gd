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
	get_tree().change_scene_to_file("res://Scene/scene_credits.tscn")


func _on_button_pressed():
	get_tree().quit()


func _on_btn_suprimer_sauvegarde_pressed():
	$MenuSpprimerPartie.visible = true


func _on_btn_retour_menu_supprimer_pressed():
	$MenuSpprimerPartie.visible = false


func _on_btn_supprimer_pressed():
	SingletonsDonnees.dictionaireDesDonnees.clear()
	SingletonsDonnees.SauvegarderJson()
	SingletonsDonnees.dictionaireDesDonnees = SingletonsDonnees.RemplireDictionaire()
	RenitialiserStaticVar()
	$MenuSpprimerPartie.visible = false


func RenitialiserStaticVar():
	nodeInterface.vie = 0
	nodeInterface.temps = 0
	nodeInterface.jour = 0
	nodeInterface.argent = 0
	nodeInterface.enJeu = false
	nodeInterface.nbHeureTravail
	nodeInterface.boissonConsome = 0
	nodeInterface.intelligence = 0
	nodeInterface.niveauIntelligence = 0
	nodeInterface.volumeDesVois = 80


func _on_btn_vidéos_pressed():
	get_tree().change_scene_to_file("res://Scene/Script/scene_menu_aide.tscn")
