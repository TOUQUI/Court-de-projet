extends Node2D

signal dormir()

var joueurLit = false
var joueurFrigidaire = false


func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/SceneMaison.tscn"


func _input(event):
	if event.is_action_pressed("interaction") && joueurLit:
		_dormire()
	elif event.is_action_pressed("interaction") && joueurFrigidaire:
		$Frigidaire/F.visible = false
		$FrigidaireTexte.visible = true


func _on_porte_body_entered(body):
	$MenuDeplacement.visible = true


func _on_porte_body_exited(body):
	$MenuDeplacement.visible = false


func _on_lit_body_entered(body):
	joueurLit = true
	$Lit/F.visible = true


func _on_lit_body_exited(body):
	joueurLit = false
	$Lit/F.visible = false

func _dormire():
	$CanvasLayer/nuit.play("dormire")
	$Chrono2_4.start()


func _on_chrono_2_4_timeout():
	dormir.emit()


func _on_frigidaire_body_entered(body):
	joueurFrigidaire = true
	$Frigidaire/F.visible = true


func _on_frigidaire_body_exited(body):
	joueurFrigidaire = false
	$Frigidaire/F.visible = false
	$FrigidaireTexte.visible = false


func _on_btn_travail_pressed():
	get_tree().change_scene_to_file("res://Scene/scene_travail.tscn")


func _on_btn_ecole_pressed():
	find_child("Joueur").derniere_emplacement = "Exterieur"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


func _on_btn_retour_pressed():
	$MenuDeplacement.visible = false
