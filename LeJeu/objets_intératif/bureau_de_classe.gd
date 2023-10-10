extends Node2D

signal joueurEnClasse(heure:int)

var joueur_dans_zone = false
 

func _input(event):
	if event.is_action_pressed("interaction") && joueur_dans_zone:
		joueurEnClasse.emit(10)
		$F.visible = false

func _on_zone_body_entered(body):
	joueur_dans_zone = true
	$F.visible = true


func _on_zone_body_exited(body):
	joueur_dans_zone = false
	$F.visible = false
