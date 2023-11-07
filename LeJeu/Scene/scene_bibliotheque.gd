extends Node2D

var joueurDansZoneBoss = false
var quete
var nodeInterface
var joueur

func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/scene_bibliotheque.tscn"
	joueur = find_child("Joueur")
	joueur.derniere_emplacement= "Blibli"
	nodeInterface = find_child("Joueur")
	nodeInterface = nodeInterface.find_child("Joueur_interface")
	AfficherMartin()


func _input(event):
	if event.is_action_pressed("interaction") && joueurDansZoneBoss:
		$MenuBoss.visible = true
		if nodeInterface.niveauIntelligence >= 4 && nodeInterface.temps == 0 && SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel == "mission3_ac":
			$MenuBoss/btnCombattre.disabled = false
			$MenuBoss.visible = true


func AfficherMartin():
	quete = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	if quete == "mission3_bc" || quete == "mission3_ac":
		$bossCollision.collision_layer = true
		$Zone/ZoneBoss.visible = true
		$EnnemieUn.visible = true
		$EnnemieUn/image/AnimationPlayer.play("pasBouger")
	else:
		$MenuBoss.visible = false


func _on_zone_boss_body_entered(body):
	joueurDansZoneBoss = true
	$f.visible = true


func _on_zone_boss_body_exited(body):
	joueurDansZoneBoss = false
	$MenuBoss.visible = false
	$f.visible = false


func _on_btn_combattre_pressed():
	get_tree().change_scene_to_file("res://Scene/scene_combat.tscn")


func _on_btn_retour_pressed():
	$MenuBoss.visible = true


func _on_sortie_body_entered(body):
	get_tree().change_scene_to_file("res://Scene/SceneCorridorD.tscn")
