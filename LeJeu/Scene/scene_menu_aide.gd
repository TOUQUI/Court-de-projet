extends Node2D


var videoLance = false
var videoNode


func _on_retour_pressed():
	get_tree().change_scene_to_file("res://Scene/menu_principale.tscn")


func _on_video_stream_player_finished():
	videoLance = false
	$AspectRatioContainer.visible = false


func Charger(source):
	if videoLance == false:
		videoLance = true
		$AspectRatioContainer.visible = true
		videoNode = load(source)
		$AspectRatioContainer/VideoStreamPlayer.set_stream(videoNode)
		$AspectRatioContainer/VideoStreamPlayer.play()


func _on_déplacement_pressed():
	Charger("res://vidéos/aswd-converted.ogv")


func _on_courir_pressed():
	Charger("res://vidéos/courrir.ogv")


func _on_inventaire_pressed():
	Charger("res://vidéos/E.ogv")


func _on_interaction_pressed():
	Charger("res://vidéos/F-converted.ogv")


func _on_quiter_pressed():
	Charger("res://vidéos/esc -converted.ogv")


func _on_travailler_pressed():
	Charger("res://vidéos/travailler-converted.ogv")


func _on_dormir_pressed():
	Charger("res://vidéos/dormir-converted.ogv")


func _on_étudier_pressed():
	Charger("res://vidéos/etudier.ogv")


func _on_gagner_vie_pressed():
	Charger("res://vidéos/manger-converted.ogv")
