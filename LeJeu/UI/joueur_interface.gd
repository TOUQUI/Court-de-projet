extends CanvasLayer

const MAXBOISSONPARJOUR = 5
static var vie = 0
static var temps = 0
static var jour = 0
static var argent = 0
static var enJeu = false
static var nbHeureTravail
static var boissonConsome = 0
static var intelligence = 0
static var niveauIntelligence = 0
static var volumeDesVois = 80
var inventaireOuvert = false
var emplacementDansLivre = ""
var joueurNode
var quetes
var nodeTxtFini
var livreAEteFermer = false
var musique
var donneesChemain = "res://Données/texte.json"
var texte = {}
var dossier
var convertion


static var inventaire =[ 
	{
		"quantité": 0
	},
	{
		"quantité": 0
	},
	{
		"quantité": 0
	}
]


func _ready():
	$Livre/SpriteLivre.visible = false
	$Livre/LivreOuvertureFermeture.visible = false
	ChargerTexte()
	ChargerDonnees()
	chargerJour()
	chargerTemps()
	ChargerVie()
	GererAffichageArgent()
	ChargerIntelligence()
	ChargerQuantiéInventaire()

func _input(event):
	if event.is_action_pressed("Inventaire"):
		if $Livre/SpriteLivre.visible == false:
			inventaireOuvert = true
			rendreInvisible()
			$Chrono0_7.start()
			$Livre/LivreOuvertureFermeture.visible = true
			$Livre/LivreOuvertureFermeture/AnimationLiverFetO.play("Ouverture")
		else:
			inventaireOuvert = false
			$Livre/SpriteLivre.visible = false
			$Chrono0_7.start()
			$Livre/LivreOuvertureFermeture.visible = true
			livreAEteFermer = true
			rendreInvisible()
			$Livre/LivreOuvertureFermeture/AnimationLiverFetO.play("Fermeture")


func ChargerVie():
	if vie < 0:
		vie = 0
	$Vie/BarDeVie.value = vie
	$Vie/QtVie.text = str(vie)

func ChargerIntelligence():
	if intelligence == 100:
		niveauIntelligence = niveauIntelligence + 1
		intelligence = 0
	$Livre/SpriteLivre/Accueil/StatIntelligence/Intelligence.text = "Niveau d'intelligence:" + str(niveauIntelligence)
	$Livre/SpriteLivre/Accueil/StatIntelligence/barIntelligence.value = intelligence


func ChargerTexte():
	if FileAccess.file_exists(donneesChemain):
		dossier = FileAccess.open(donneesChemain, FileAccess.READ)
		convertion = JSON.parse_string(dossier.get_as_text())
		if convertion is Dictionary:
			dossier.close()
			texte = convertion


func ChargerQuete():
	quetes = texte["Mission"]
	for item in quetes:
		if SingletonsDonnees.dictionaireDesDonnees["Mission"][str(item)].Etat == "Fini":
			nodeTxtFini = get_node("Livre/SpriteLivre/Quête/Fini/" + str(item))
			nodeTxtFini.text = quetes[item].Titre
		elif SingletonsDonnees.dictionaireDesDonnees["Mission"][str(item)].Etat == "Actuel":
			$"Livre/SpriteLivre/Quête/Actuel/Titre".text = quetes[item].Titre
			$"Livre/SpriteLivre/Quête/Actuel/Description".text = quetes[item].Description


func ChargerDonnees():
	if !enJeu:
		enJeu = true
		inventaire[0].quantité = SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem1
		inventaire[1].quantité = SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem2
		inventaire[2].quantité = SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem3
		jour = SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbJour
		argent = SingletonsDonnees.dictionaireDesDonnees["DataSession"].argent
		temps = SingletonsDonnees.dictionaireDesDonnees["DataSession"].temps
		nbHeureTravail = SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbTempsTravail
		boissonConsome = SingletonsDonnees.dictionaireDesDonnees["DataSession"].boisonConsome
		vie = SingletonsDonnees.dictionaireDesDonnees["DataSession"].vie
		intelligence = SingletonsDonnees.dictionaireDesDonnees["DataSession"].intelligence
		niveauIntelligence = SingletonsDonnees.dictionaireDesDonnees["DataSession"].niveauIntelligence
		ChargerQuete()


func SauvegarderDonnees():
	SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem1 = inventaire[0].quantité
	SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem2 = inventaire[1].quantité
	SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem3 = inventaire[2].quantité
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbJour = jour
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].argent = argent
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].temps = temps
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].boisonConsome = boissonConsome
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].vie = vie
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].intelligence = intelligence
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].niveauIntelligence = niveauIntelligence
	SingletonsDonnees.SauvegarderJson()


func _on_joueur_joueur_étudie(heure):
	if temps <= 80:
		temps = temps + heure
		intelligence = intelligence + 10
		ChargerIntelligence()
		chargerTemps()


func _on_chrono_0_5_timeout():
	if livreAEteFermer == false:
		if emplacementDansLivre == "i":
			$Livre/SpriteLivre/Inventaire.visible = true
		elif emplacementDansLivre == "p":
			$Livre/SpriteLivre/Options.visible = true
		elif emplacementDansLivre == "m":
			ChargerQuete()
			$"Livre/SpriteLivre/Quête".visible = true
	else:
		livreAEteFermer = false


func _on_chrono_0_7_timeout():
	if inventaireOuvert == true:
		$Livre/LivreOuvertureFermeture.visible = false
		$Livre/SpriteLivre.visible = true
		$Livre/SpriteLivre/Accueil.visible = true
	else:
		$Livre/LivreOuvertureFermeture.visible = false


func rendreInvisible():
	if $Livre/SpriteLivre/Inventaire.visible == true:
		$Livre/SpriteLivre/Inventaire.visible = false
	elif $Livre/SpriteLivre/Options.visible == true:
		$Livre/SpriteLivre/Options.visible = false
	elif $"Livre/SpriteLivre/Quête".visible  == true:
		$"Livre/SpriteLivre/Quête".visible = false
	elif $Livre/SpriteLivre/Accueil.visible == true:
		$Livre/SpriteLivre/Accueil.visible = false


func _on_image_inventaire_pressed():
	livreAEteFermer = false
	ChangerDePage("i", "TournerPageVersGauche")


func _on_btn_quete_pressed():
	livreAEteFermer = false
	ChangerDePage("m", "TournerPageVersGauche")


func _on_btn_parametre_pressed():
	livreAEteFermer = false
	ChangerDePage("p", "TournerPageVersDroite")


func ChangerDePage(page, direction):
	$Livre/SpriteLivre/AnimationLivre.play(direction)
	rendreInvisible()
	emplacementDansLivre = page
	$Chrono0_5.start()


func ChargerQuantiéInventaire():
	$Livre/SpriteLivre/Inventaire/Item1/qtItem1.text = str(inventaire[0].quantité)
	$Livre/SpriteLivre/Inventaire/Item2/qtItem2.text = str(inventaire[1].quantité)
	$Livre/SpriteLivre/Inventaire/Item3/qtItem3.text = str(inventaire[2].quantité)

func _on_joueur_ajouter_item_acheter(item, prix):
	if argent >= prix:
		argent = argent - prix
		inventaire[item - 1].quantité = inventaire[item - 1].quantité + 1
		if item == 1:
			$Livre/SpriteLivre/Inventaire/Item1/qtItem1.text = str(inventaire[item - 1].quantité)
		elif  item == 2:
			$Livre/SpriteLivre/Inventaire/Item2/qtItem2.text = str(inventaire[item - 1].quantité)
		elif  item == 3:
			$Livre/SpriteLivre/Inventaire/Item3/qtItem3.text = str(inventaire[item - 1].quantité)
		GererAffichageArgent()

func chargerJour():
	$Jour/nbJour.text = "JOUR:" + str(jour)

func chargerTemps():
	$Horloge/TextureProgressBar.value = temps

func _on_joueur_dormir():
	jour = jour + 1
	temps = 0
	boissonConsome = 0
	chargerJour()
	chargerTemps()
	SauvegarderDonnees()


func _on_btn_consomer_item_1_pressed():
	ConsommerBoissonQuiRetireTemps(0)


func _on_btn_consomer_item_2_pressed():
	ConsommerBoissonQuiRetireTemps(1)


func _on_btn_consomer_item_3_pressed():
	if vie < 100 && retirerItem(3):
		AjouterVie(25)


func retirerItem(item):
	if inventaire[item - 1].quantité > 0:
		inventaire[item - 1].quantité = inventaire[item - 1].quantité - 1
		ChargerQuantiéInventaire()
		return true
	else:
		return false


func ConsommerBoissonQuiRetireTemps(item):
	if  boissonConsome < MAXBOISSONPARJOUR && inventaire[item].quantité >= 1 && temps >= 20:
		boissonConsome = boissonConsome + 1
		temps = temps - 20
		inventaire[item].quantité = inventaire[item].quantité - 1
		ChargerQuantiéInventaire()
		chargerTemps()
	elif temps == 0:
			$Message.visible = true
			$Message.text = "Le temps est à zero le gros."
			$Message/MessageMinuterie.start()
	elif boissonConsome >= MAXBOISSONPARJOUR:
		$Message.visible = true
		$Message.text = "Je pense que mon cœur va exploser si j'en prends un autre aujourd'hui!"
		$Message/MessageMinuterie.start()

func _on_joueur_sauvegarder():
	SauvegarderDonnees()


func _on_joueur_joueur_travail(salaire):
	if temps <= 90:
		temps = temps + 10
		argent = argent + salaire
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbTempsTravail = SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbTempsTravail + 1
		GererAffichageArgent()
		chargerTemps()


func GererAffichageArgent():
	$Argent/nbArgent.text = "ARGENT:" + str(argent) + "$"


func _on_message_minuterie_timeout():
	$Message.visible = false
	$Message.text = ""


func EnleverVie(valeur):
	vie = vie - valeur
	ChargerVie()


func AjouterVie(valeur):
	if (vie + valeur) > 100:
		vie = 100
	else:
		vie = vie + valeur
	ChargerVie()


func _on_joueur_enlever_vie(valeur):
	EnleverVie(valeur)
	ChargerVie()


func _on_joueur_ajouter_vie(valeur):
	AjouterVie(valeur)
	ChargerVie()


func _on_joueur_ajouter_vie_retirer_argent(pVie, prix):
	if argent >= prix && vie <= 99:
		argent = argent - prix
		if (vie + pVie) > 100:
			vie = 100
		else:
			vie = vie + pVie
		ChargerVie()
		GererAffichageArgent()


func LancerQueteDuDebut():
	pass


func _on_joueur_joueur_attaque(valeur):
		if temps <= (100 - valeur):
			temps = temps + valeur
			chargerTemps()


func _on_gestion_volume_value_changed(value):
	musique = MusicManager.find_child("Musique")
	if value == 50:
		musique.volume_db = -80
	elif value > 50 && value <= 80:
		musique.volume_db = -80 + value
	elif value > 80:
		musique.volume_db = value - 80
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].volumeMusique = musique.volume_db


func _on_h_slider_value_changed(value):
	if value == 50:
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].volumeVoix = -80
	elif value > 50 && value <= 80:
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].volumeVoix = -80 + value
	elif value > 80:
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].volumeVoix = value - 80 
