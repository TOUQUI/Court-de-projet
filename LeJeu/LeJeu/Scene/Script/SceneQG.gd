extends StaticBody2D


func _on_area_2d_body_entered(body):
	find_child("Joueur").derniere_emplacement = "QG"
	get_tree().change_scene_to_file("res://Scene/SceneCorridorG.tscn")


func _on_button_pressed():
	pass # Replace with function body.
