extends CanvasLayer

static var temps = 0
var inventaireOuvert = false
var emplacementDansLivre = ""


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
	$Horloge/TextureProgressBar.value = temps
	chargerQuantiéInventaire()

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

func _on_joueur_joueur_étudie(heure):
	temps =  temps + heure
	$Horloge/TextureProgressBar.value = temps


func _on_chrono_0_5_timeout():
	if emplacementDansLivre == "i":
		$Livre/SpriteLivre/Inventaire.visible = true
	elif emplacementDansLivre == "p":
		pass


func _on_chrono_0_7_timeout():
	if inventaireOuvert == true:
		$Livre/LivreOuvertureFermeture.visible = false
		$Livre/SpriteLivre.visible = true
	else:
		$Livre/LivreOuvertureFermeture.visible = false


func rendreInvisible():
	if $Livre/SpriteLivre/Inventaire.visible == true:
		$Livre/SpriteLivre/Inventaire.visible = false
	else:
		pass


func _on_image_inventaire_pressed():
	$Livre/SpriteLivre/AnimationLivre.play("TournerPageVersGauche")
	rendreInvisible()
	emplacementDansLivre = "i"
	$Chrono0_5.start() 


func _on_btn_parametre_pressed():
	$Livre/SpriteLivre/AnimationLivre.play("TournerPageVersDroite")
	rendreInvisible()
	emplacementDansLivre = "p"
	$Chrono0_5.start()

func chargerQuantiéInventaire():
	$Livre/SpriteLivre/Inventaire/Item1/qtItem1.text = str(inventaire[0].quantité)
	$Livre/SpriteLivre/Inventaire/Item2/qtItem2.text = str(inventaire[1].quantité)
	$Livre/SpriteLivre/Inventaire/Item3/qtItem3.text = str(inventaire[2].quantité)

func _on_joueur_ajouter_item_acheter(item):
	inventaire[item - 1].quantité = inventaire[item - 1].quantité + 1
	if item == 1:
		$Livre/SpriteLivre/Inventaire/Item1/qtItem1.text = str(inventaire[item - 1].quantité)
	elif  item == 2:
		$Livre/SpriteLivre/Inventaire/Item2/qtItem2.text = str(inventaire[item - 1].quantité)
	elif  item == 3:
		$Livre/SpriteLivre/Inventaire/Item3/qtItem2.text = str(inventaire[item - 1].quantité)
