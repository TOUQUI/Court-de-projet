extends StaticBody2D


func _ready():
	find_child("Joueur").derniere_emplacement = "QG"
	find_child("Joueur").emplacementActuel = "res://Scene/node_SceneQG.tscn"


func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://Scene/SceneCorridorG.tscn")

