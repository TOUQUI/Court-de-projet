extends Node2D

var joueurDirection
var provenance
var joueur_node
var joueurDansZone4823 = false
var joueurDansZoneBossUn = false


func _ready():
	joueur_node = get_node("Joueur")
	provenance = joueur_node.derniere_emplacement
	if provenance == "4923":
		$Joueur.position = Vector2(-320,-278)


func _input(event):
	if event.is_action_pressed("interaction"):
		if joueurDansZone4823:
			joueurDirection = "res://Scene/scene_4823.tscn"
			$Porte4823/AnimationPorte4823.play("ouverture")
			$AttentePorte.start()
		elif joueurDansZoneBossUn:
			if SingletonsDonnees.dictionaireDesDonnees["DataSession"].niveauIntelligence >= 1:
				$MessageBoss/btnCombat.disabled = false
			$MessageBoss.visible = true


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
	get_tree().change_scene_to_file(joueurDirection)


func _on_porte_boss_un_body_entered(body):
	joueurDansZoneBossUn = true
	$PorteBossUn/F.visible = true


func _on_porte_boss_un_body_exited(body):
	joueurDansZoneBossUn = false
	$MessageBoss.visible = false
	$PorteBossUn/F.visible = false


func _on_btn_combat_pressed():
	get_tree().change_scene_to_file("res://Scene/scene_combat.tscn")


func _on_btn_retour_pressed():
	$MessageBoss.visible = false
