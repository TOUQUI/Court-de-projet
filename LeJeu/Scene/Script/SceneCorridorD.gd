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
	nodeInterface = find_child("Joueur")
	nodeInterface = nodeInterface.find_child("Joueur_interface")
	AfficherMartin()
	joueur_node.derniere_emplacement = "D"
	if quete == "mission3_bc":
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false


func _input(event):
	if event.is_action_pressed("interaction"):
		if joueurDansZone4823:
			joueurDirection = "res://Scene/scene_4823.tscn"
			joueur.derniere_emplacement = "4823"
			$Porte4823/AnimationPorte4823.play("ouverture")
			$AttentePorte.start()
		elif joueurDansZoneBossDeux:
			if nodeInterface.niveauIntelligence >= 4 && nodeInterface.temps == 0 && SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel == "mission3_ac":
				$MessageBoss/btnCombat.disabled = false
			$MessageBoss.visible = true


func AfficherMartin():
	quete = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	if quete == "mission3_bc" || quete == "mission3_ac":
		$colissionMartin.visible = true
		$EnnemieUn.visible = true
		$EnnemieUn/image/AnimationPlayer.play("pasBouger")
	else:
		$BoiteDeTextes.visible = false


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
	$MessageBoss.visible = false
	$PorteBossDeux/F.visible = false


func _on_btn_combat_pressed():
	get_tree().change_scene_to_file("res://Scene/scene_combat.tscn")


func _on_btn_retour_pressed():
	$MessageBoss.visible = false


func _on_vers_bureau_prof_body_entered(body):
	joueur.derniere_emplacement = "BureauProf"
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false
	get_tree().change_scene_to_file("res://Scene/sceneBureauProf.tscn")
