extends Area2D

var joueur_detecte = false

func _ready():
	$F.visible = false


func _on_détecteur_joueur_body_entered(body):
	joueur_detecte = true
	$F.visible = true


func _on_détecteur_joueur_body_exited(body):
	joueur_detecte = false
	$F.visible = false

func _input(event):
	if event.is_action_pressed("interaction") && joueur_detecte:
		$AnimationPlayer.play("Ouverture")
		$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scene/SceneQG.tscn")
