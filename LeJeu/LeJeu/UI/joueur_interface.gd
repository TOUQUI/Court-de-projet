extends CanvasLayer

static var temps = 0
var inventaireOuvert = false

func _ready():
	$Livre/SpriteLivre.visible = false
	$Livre/LivreOuvertureFermeture.visible = false
	$Horloge/TextureProgressBar.value = temps

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
			$Livre/LivreOuvertureFermeture/AnimationLiverFetO.play("Fermeture")

func _on_joueur_joueur_étudie(heure):
	temps =  temps + heure
	$Horloge/TextureProgressBar.value = temps


func _on_chrono_0_5_timeout():
	pass


func _on_chrono_0_7_timeout():
	if inventaireOuvert == true:
		$Livre/LivreOuvertureFermeture.visible = false
		$Livre/SpriteLivre.visible = true
	else:
		$Livre/LivreOuvertureFermeture.visible = false


func _on_btn_parametre_pressed():
	$Livre/SpriteLivre/AnimationLivre.play("TournerPageVersDroite")
	$Chrono0_5.start()


func _on_btn_inventaire_pressed():
	$Livre/SpriteLivre/AnimationLivre.play("TournerPageVersGauche")
	$Chrono0_5.start()
