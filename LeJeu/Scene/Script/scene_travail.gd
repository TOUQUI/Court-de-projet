extends Node2D

signal travailler(salaire:int)
signal joyeuxRepasSurPlace(vie:int, prix:int)
signal joyeuxRepasEmporter(item:int, prix:int)

var poste
var champPoste
var salaire
var tempsCarière
var tempsJourne

func _ready():
	find_child("Joueur").emplacementActuel = "res://Scene/scene_travail.tscn"
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
	$Travailler/txtDescription.text = "     Travailler enlève 1 heure à votre journée
	 et en échange vous recevez " + str(salaire) + "$."
	$Travailler/txtPoste.text = "Vous êtes : " + champPoste


func GererAffichageNbHeure():
	$Travailler/txtNbHeure.text = "Nombre d'heure(s) : " + str(tempsCarière)

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
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].posteMcdo = poste
	GererAffichagePEtD()


func _on_joueur_envoie_heure(temps):
	tempsJourne = temps



func _on_entrer_travailler_pressed():
	$Menu.visible = false
	$Travailler.visible = true
	$Changer.visible = true
	$Changer.text = "Manger"


func _on_entrer_manger_pressed():
	$Menu.visible = false
	$Manger.visible = true
	$Changer.visible = true
	$Changer.text = "Travailler"


func _on_acheter_sur_place_pressed():
	joyeuxRepasSurPlace.emit(25,10)


func _on_acheter_emporter_pressed():
	joyeuxRepasEmporter.emit(3,10)


func _on_changer_pressed():
	if $Travailler.visible == true:
		$Travailler.visible = false
		$Manger.visible = true
		$Changer.text = "Travailler"
	else:
		$Manger.visible = false
		$Travailler.visible = true
		$Changer.text = "Manger"
