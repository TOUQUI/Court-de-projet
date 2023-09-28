extends Area2D

var joueur_detecte = false
var parent_node
var joueur_node

func _ready():
	parent_node = get_parent()
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
		if parent_node.name == "Corridor_G":
			parent_node.find_child("Joueur").derniere_emplacement = "GP"
		$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://node_SceneQG.tscn")
