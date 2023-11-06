extends Node2D

var animatioJose
var joueurDansZoneJose = false
var nodeInterface

func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/sceneBureauProf.tscn"
	find_child("Joueur").derniere_emplacement = "BureauProf"
	$Jose/image/AnimationPlayer.play("pasBouger")
	nodeInterface = find_child("Joueur")
	nodeInterface.position = Vector2(413,504)
	nodeInterface = nodeInterface.find_child("Joueur_interface")


func _input(event):
	if event.is_action_pressed("interaction") && joueurDansZoneJose:
		$menuCombat.visible = true
		if nodeInterface.niveauIntelligence >= 1 && nodeInterface.temps == 0 && SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel == "mission1_ac":
			$menuCombat/btnCombattre.disabled = false


func _on_sortie_body_entered(body):
	find_child("Joueur").derniere_emplacement = "BureauProf"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorD.tscn")


func _on_zone_jose_body_entered(body):
	joueurDansZoneJose = true
	$F.visible = true


func _on_zone_jose_body_exited(body):
	joueurDansZoneJose = false
	$menuCombat.visible = false
	$F.visible = false


func _on_retour_pressed():
	$menuCombat.visible = false


func _on_combattre_pressed():
	get_tree().change_scene_to_file("res://Scene/scene_combat.tscn")


func _on_area_2d_area_entered(area):
	print("fndjsndgl")
