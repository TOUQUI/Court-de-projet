extends Node2D


signal EnleverVieJoueur(valeur:int)

const ennemie = ["EnnemieUn", "EnnemieDeux"]
var auTourDuJoueur = true
var vieBoss = 0


func _ready():
	pass


func tourJoueur():
	$Tuile_boite_de_texte/btnFuire.enabled = true
	$Tuile_boite_de_texte/btnAttaqueSpecial.enabled = true
	$Tuile_boite_de_texte/btnFuire.enabled = true
	$Tuile_boite_de_texte/btnPetiteAttaque.enabled = true


func tourBoss():
	$Tuile_boite_de_texte/btnFuire.enabled = false
	$Tuile_boite_de_texte/btnAttaqueSpecial.enabled = false
	$Tuile_boite_de_texte/btnFuire.enabled = false
	$Tuile_boite_de_texte/btnPetiteAttaque.enabled = false
