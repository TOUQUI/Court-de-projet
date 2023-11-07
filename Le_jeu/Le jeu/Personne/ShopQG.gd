extends Area2D

var joueur_dans_zone = false

func _on_body_entered(body):
	joueur_dans_zone = true
	$F.visible = true


func _on_body_exited(body):
	joueur_dans_zone = false
	$F.visible = false
