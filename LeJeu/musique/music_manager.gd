extends Node2D

var rng = RandomNumberGenerator.new()
var musique
var musiqueTitre
var scene_tree = get_tree()
var tempsDeLaMusique 


func _ready():
	if $Musique.stream == null:
		rng = rng.randf_range(0, 1)
		if rng == 0:
			ChargerChillpeach()
		else:
			ChargerMassobeats()
		$Musique.stream = musique
		$Musique.play()
	else:
		$Musique.play()


func ChargerMassobeats():
	musique = load("res://musique/massobeats.mp3")
	musiqueTitre = "massobeats"

func ChargerChillpeach():
	musique = load("res://musique/Chillpeach.mp3")
	musiqueTitre = "Chillpeach"




func _on_musique_finished():
	if musiqueTitre == "massobeats":
		ChargerChillpeach()
	else:
		ChargerMassobeats()
	$Musique.stream = musique
	$Musique.play()
