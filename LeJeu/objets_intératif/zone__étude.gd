extends Node2D

var joueur_dans_zone = false
signal joueur_étudie

func _ready():
	$Menu.visible = false

func _input(event):
	if event.is_action_pressed("interaction") && joueur_dans_zone:
		$Menu.visible = true

func _on_zone_body_entered(body):
	joueur_dans_zone = true


func _on_zone_body_exited(body):
	joueur_dans_zone = false
	$Menu.visible = false


func _on_btn_étudier_pressed():
	joueur_étudie.emit()


func _on_btn_quiter_pressed():
	$Menu.visible = false
