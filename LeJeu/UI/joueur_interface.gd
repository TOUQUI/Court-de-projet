extends CanvasLayer

const MAXBOISONPARJOUR = 5
static var temps = 0
static var jour = 0
static var argent = 0
static var enJeu = false
static var nbHeureTravail
static var boisonConsome = 0
var inventaireOuvert = false
var emplacementDansLivre = ""
var joueurNode
var quetes
var nodeTxtFini


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
	ChargerDonnees()
	chargerQuantiéInventaire()
	chargerJour()
	chargerTemps()
	GererAffichageArgent()

func _input(event):
	if event.is_action_pressed("Inventaire"):
		if $Livre/SpriteLivre.visible == false:
			inventaireOuvert = true
			$Chrono0_7.start()
			$Livre/LivreOuvertureFermeture.visible = true
			$Livre/LivreOuvertureFermeture/AnimationLiverFetO.play("Ouverture")
		else:
			inventaireOuvert = false
			$Livre/SpriteLivre.visible = false
			$Chrono0_7.start()
			$Livre/LivreOuvertureFermeture.visible = true
			$Livre/SpriteLivre/Inventaire.visible = false
			$Livre/LivreOuvertureFermeture/AnimationLiverFetO.play("Fermeture")


func ChargerQuete():
	quetes = SingletonsDonnees.dictionaireDesDonnees["Mission"]
	for item in quetes:
		if quetes[item].Etat == "Fini":
			nodeTxtFini = get_node("Livre/SpriteLivre/Quête/Fini/" + str(item))
			nodeTxtFini.text = quetes[item].Titre
		elif quetes[item].Etat == "Actuel":
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
		boisonConsome = SingletonsDonnees.dictionaireDesDonnees["DataSession"].boisonConsome
		ChargerQuete()

func SauvegarderDonnees():
	SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem1 = inventaire[0].quantité
	SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem2 = inventaire[1].quantité
	SingletonsDonnees.dictionaireDesDonnees["Inventaire"].qtItem3 = inventaire[2].quantité
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].nbJour = jour
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].argent = argent
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].temps = temps
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].boisonConsome = boisonConsome
	SingletonsDonnees.SauvegarderJson()

func _on_joueur_joueur_étudie(heure):
	if temps <= 80:
		temps = temps + heure
		chargerTemps()


func _on_chrono_0_5_timeout():
	if emplacementDansLivre == "i":
		$Livre/SpriteLivre/Inventaire.visible = true
	elif emplacementDansLivre == "p":
		$Livre/SpriteLivre/Options.visible = true
	elif emplacementDansLivre == "m":
		$"Livre/SpriteLivre/Quête".visible = true


func _on_chrono_0_7_timeout():
	if inventaireOuvert == true:
		$Livre/LivreOuvertureFermeture.visible = false
		$Livre/SpriteLivre.visible = true
	else:
		$Livre/LivreOuvertureFermeture.visible = false


func rendreInvisible():
	if $Livre/SpriteLivre/Inventaire.visible == true:
		$Livre/SpriteLivre/Inventaire.visible = false
	elif $Livre/SpriteLivre/Options.visible == true:
		$Livre/SpriteLivre/Options.visible = false
	elif $"Livre/SpriteLivre/Quête".visible  == true:
		$"Livre/SpriteLivre/Quête".visible = false


func _on_image_inventaire_pressed():
	ChangerDePage("i", "TournerPageVersGauche")


func _on_btn_quete_pressed():
	ChangerDePage("m", "TournerPageVersGauche")


func _on_btn_parametre_pressed():
	ChangerDePage("p", "TournerPageVersDroite")


func ChangerDePage(page, direction):
	$Livre/SpriteLivre/AnimationLivre.play(direction)
	rendreInvisible()
	emplacementDansLivre = page
	$Chrono0_5.start()


func chargerQuantiéInventaire():
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
			$Livre/SpriteLivre/Inventaire/Item3/qtItem2.text = str(inventaire[item - 1].quantité)
		GererAffichageArgent()

func chargerJour():
	$Jour/nbJour.text = "JOUR:" + str(jour)

func chargerTemps():
	$Horloge/TextureProgressBar.value = temps

func _on_joueur_dormir():
	jour = jour + 1
	temps = 0
	boisonConsome = 0
	chargerJour()
	chargerTemps()
	SauvegarderDonnees()


func _on_btn_consomer_item_1_pressed():
	if  boisonConsome < MAXBOISONPARJOUR && inventaire[0].quantité >= 1 && temps >= 20:
		boisonConsome = boisonConsome + 1
		temps = temps - 20
		inventaire[0].quantité = inventaire[0].quantité - 1
		chargerQuantiéInventaire()
		chargerTemps()
	elif temps == 0:
			$Message.visible = true
			$Message.text = "Le temps est à zero le gros."
			$Message/MessageMinuterie.start()
	elif boisonConsome >= MAXBOISONPARJOUR:
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
