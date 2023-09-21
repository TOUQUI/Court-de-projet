extends StaticBody2D

func _on_c_gvers_cm_body_entered(body):
	find_child("Joueur").derniere_emplacement = "G"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")
