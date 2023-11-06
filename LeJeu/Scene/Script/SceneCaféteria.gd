extends Node2D

signal acheterCafé(item:int, prix:int)

var joueurDansZone = false
var joueurZoneCombat = false
var nodeInterface
var joueur = preload("res://Joueur/joueur.gd")


func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/SceneCaféteria.tscn"
	nodeInterface = find_child("Joueur")
	nodeInterface = nodeInterface.find_child("Joueur_interface")


func _input(event):
	if event.is_action_pressed("interaction") && joueurDansZone == true:
		$MenuCafeteria.visible = true
	elif event.is_action_pressed("interaction") && joueurZoneCombat == true:
		$menuBoss.visible = true
		if nodeInterface.niveauIntelligence >= 6 && nodeInterface.temps == 0 && SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel == "mission4_bc":
			$menuBoss/btnCombattre.disabled = false


func _on_porte_body_entered(body):
	find_child("Joueur").derniere_emplacement = "Exterieur"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


func _on_zone_vente_body_entered(body):
	joueurDansZone = true
	$ZoneVente2/F.visible = true


func _on_zone_vente_body_exited(body):
	joueurDansZone = false
	$ZoneVente2/F.visible = false
	$MenuCafeteria.visible = false


func _on_zone_vente_2_body_entered(body):
	joueurDansZone = true
	$ZoneVente/F.visible = true


func _on_zone_vente_2_body_exited(body):
	joueurDansZone = false
	$ZoneVente/F.visible = false
	$MenuCafeteria.visible = false


func _on_button_pressed():
	acheterCafé.emit(2,20)


func _on_porte_combat_body_entered(body):
	$PorteCombat/F.visible = true
	joueurZoneCombat = true


func _on_porte_combat_body_exited(body):
	$PorteCombat/F.visible = false
	$menuBoss.visible = false
	joueurZoneCombat = false


func _on_btn_retour_pressed():
	$menuBoss.visible = false


func _on_btn_combattre_pressed():
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false
	joueur.derniere_emplacement = "Cafetreria"
	get_tree().change_scene_to_file("res://Scene/scene_combat.tscn")
