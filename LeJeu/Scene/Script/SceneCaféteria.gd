extends Node2D

signal acheterCafé(item:int, prix:int)

var joueurDansZone = false


func _input(event):
	if event.is_action_pressed("interaction") && joueurDansZone == true:
		$MenuCafeteria.visible = true


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
