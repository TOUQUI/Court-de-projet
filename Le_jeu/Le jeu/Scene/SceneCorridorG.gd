extends StaticBody2D

var player_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_c_gvers_cm_body_entered(body):
	find_child("Joueur").derniere_emplacement = "G"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")
