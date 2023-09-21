extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_area_2d_body_entered(body):
	find_child("Joueur").derniere_emplacement = "QG"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorG.tscn")
