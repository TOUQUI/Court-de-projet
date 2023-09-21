extends StaticBody2D

func _on_q_gvers_g_body_entered(body):
	find_child("Joueur").derniere_emplacement = "QG"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorG.tscn")
