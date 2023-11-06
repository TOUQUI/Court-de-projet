extends Node2D

signal joueurÉtudieEnClasse(heure:int)

var nodes
var joueurDansZoneCombat = false
var nodeInterface
var quete
var joueur = preload("res://Joueur/joueur.gd")

func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/scene_4823.tscn"
	quete = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	if quete == "mission2_bc" || quete == "mission2_ac":
		$enemie_trois.visible = true
		$enemie_trois/image/AnimationPlayer.play("pasBouger")
		$zoneNoua.visible = true
		$BossCollision.collision_layer = true
		nodeInterface = find_child("Joueur")
		nodeInterface = nodeInterface.find_child("Joueur_interface")
		joueur.derniere_emplacement = "4823"


func _input(event):
	if event.is_action_pressed("interaction") && joueurDansZoneCombat:
		$menuCombat.visible = true
		if nodeInterface.temps == 0 && nodeInterface.niveauIntelligence >= 3 && (quete == "mission2_bc" || "mission2_ac"):
			$menuCombat/btnCombattre.disabled = false


func ConnecterBureau():
	nodes = get_node("/root/NodeQG/Étude")
	nodes = nodes.get_children()
	for child in nodes:
		if !child.joueurEnClasse.is_connected(GererBureaux):
			child.joueurEnClasse.connect(GererBureaux)


func GererBureaux(heure):
	joueurÉtudieEnClasse.emit(heure)


func _on_sortie_body_entered(body):
	joueur.derniere_emplacement = "4923"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorD.tscn")


func _on_area_2d_body_entered(body):
	joueurDansZoneCombat = true
	$zoneNoua/F.visible = true


func _on_area_2d_body_exited(body):
	$menuCombat.visible = false
	$zoneNoua/F.visible = false
	joueurDansZoneCombat = false


func _on_btn_retour_pressed():
	$menuCombat.visible = false


func _on_btn_combattre_pressed():
	get_tree().change_scene_to_file("res://Scene/scene_combat.tscn")
