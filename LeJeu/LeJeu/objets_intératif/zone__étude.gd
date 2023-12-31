extends Node2D

var joueur_dans_zone = false
signal joueur_étudie(heure:int, expediteur:String)

func _ready():
	$F.visible = false
	$Menu.visible = false

func _input(event):
	if event.is_action_pressed("interaction") && joueur_dans_zone:
		$Menu.visible = true

func _on_zone_body_entered(body):
	joueur_dans_zone = true
	$F.visible = true


func _on_zone_body_exited(body):
	joueur_dans_zone = false
	$F.visible = false
	$Menu.visible = false


func _on_btn_étudier_pressed():
	joueur_étudie.emit(20, self.name)


func _on_btn_quiter_pressed():
	$Menu.visible = false
