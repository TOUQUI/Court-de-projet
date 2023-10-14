extends Node2D


func _on_porte_body_entered(body):
	find_child("Joueur").derniere_emplacement = "Exterieur"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")
