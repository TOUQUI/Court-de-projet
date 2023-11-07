extends Node2D

signal AchatCafé(item:int, prix:int)

var joueurDansZone = false


func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/scene_caféoxymel.tscn"
	$DGJT/AnimationPlayer.play("Idel")


func _input(event):
	if event.is_action_pressed("interaction") && joueurDansZone:
		$MenuMagasin.visible = true


func _on_sortie_body_entered(body):
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


func _on_zone_café_body_entered(body):
	joueurDansZone = true
	$F.visible = true


func _on_zone_café_body_exited(body):
	joueurDansZone = false
	$MenuMagasin.visible = false
	$F.visible = false


func _on_btn_acheter_café_pressed():
	AchatCafé.emit(2,2)


func _on_btn_retour_pressed():
	$MenuMagasin.visible = false
