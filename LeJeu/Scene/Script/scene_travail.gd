extends Node2D

signal travailler(salaire:int)

var poste
var champPoste
var salaire
var tempsCarière
var tempsJourne

func _ready():
	poste = SingletonsDonnees.dictionaireDesDonnees["DataSession"].posteMcdo
	tempsCarière = SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbTempsTravail
	GererAffichagePEtD()
	GererAffichageNbHeure()


func GererAffichagePEtD():
	if poste == 0:
		salaire = 15
		champPoste = "Employer"
	elif poste == 1:
		salaire = 20
		champPoste = "Assistant gerant"
	elif poste == 2:
		salaire = 25
		champPoste = "Gerant"
	elif poste == 3:
		salaire = 40
		champPoste = "Patron"
	else:
		salaire = 100
		champPoste = "PDG"
	$txtDescription.text = "Travailler enlève 1 heure à votre journée et en échange 
	vous recevez " + str(salaire) + "$."


func GererAffichageNbHeure():
	$txtNbHeure.text = "Nombre d'heure(s) : " + str(tempsCarière)

func _on_btn_travailler_pressed():
	travailler.emit(salaire)
	tempsCarière = SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbTempsTravail
	GererAffichageNbHeure()


func _on_btn_maison_pressed():
	get_tree().change_scene_to_file("res://Scene/SceneMaison.tscn")



func _on_btn_promotion_pressed():
	if tempsCarière >= 10 && tempsCarière <= 20:
		poste = 1
	elif tempsCarière >= 21 && tempsCarière <= 30:
		poste = 2
	elif tempsCarière >= 31 && tempsCarière <= 40:
		poste = 3
	elif tempsCarière >= 41 && tempsCarière <= 50:
		poste = 4


func _on_joueur_envoie_heure(temps):
	tempsJourne = temps
