extends StaticBody2D

func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/SceneCorridorD.gd"


func _on_c_dvers_cm_body_entered(body):
	find_child("Joueur").derniere_emplacement = "D"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")
