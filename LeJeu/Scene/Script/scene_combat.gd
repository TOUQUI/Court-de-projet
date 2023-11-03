extends Node2D


signal EnleverVieJoueur(valeur:int)
signal AjouterTemps(valeur:int)


const ennemie = ["EnnemieUn", "EnnemieDeux"]
var auTourDuJoueur = true
var vieBoss
var nombreAléatoire = 0
var rng = RandomNumberGenerator.new()
var nomBoss
var vieBossDeBase
var nouvelle_texture
var queteActuel 
var joueurInteligence
var joueurNode


func _ready():
	queteActuel = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	joueurNode = get_node("Joueur")
	joueurInteligence = joueurNode.find_child("Joueur_interface").niveauIntelligence
	$Personnage/AnimationPlayer.play("Bouger")
	if SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss:
		if queteActuel == "mission1_bc":
			nouvelle_texture = load("res://image/ArièrePlanBoss1.png")
			vieBoss = 100
			vieBossDeBase = vieBoss
			$Ennemie/Jose.visible = true
			nomBoss = get_node("Ennemie/Jose/image/AnimationPlayer")
		elif queteActuel == "mission2_bc":
			nouvelle_texture = load("res://image/ArièrePlanBoss2.png")
			vieBoss = 150
			vieBossDeBase = vieBoss
			$Ennemie/enemie_trois.visible = true
			nomBoss = get_node("Ennemie/enemie_trois/image/AnimationPlayer")
		elif queteActuel == "mission3_bc":
			nouvelle_texture = load("res://image/ArièrePlanBoss3.png")
			vieBoss = 200
			vieBossDeBase = vieBoss
			$Ennemie/EnnemieUn.visible = true
			nomBoss = get_node("Ennemie/EnnemieUn/image/AnimationPlayer")
			$ArièrePlan.position = Vector2(576,150)
		elif queteActuel == "mission4_bc":
			nouvelle_texture = load("res://image/ArièrePlanBoss4.png")
			vieBoss = 250
			vieBossDeBase = vieBoss
			$Ennemie/Philipe.visible = true
			nomBoss = get_node("Ennemie/Philipe/image/AnimationPlayer")
		$ArièrePlan.texture = nouvelle_texture
		$BossVie/QtVie.text = str(vieBoss)
		nomBoss.play("pasBouger")
		$ProjectileJoueur.visible = false
		TourJoueur()

func BossTouche(pPointDeViePerdue):
	vieBoss = vieBoss - pPointDeViePerdue
	if vieBoss <= 0:
		nomBoss.play("mort")
		nomBoss.play("mort")
		$BossVie/TextureProgressBar.value = 0
		$BossVie/QtVie.text = "0"
	else:
		$BossVie/TextureProgressBar.value = $BossVie/TextureProgressBar.value - ((75 * pPointDeViePerdue) / vieBossDeBase) 
		$BossVie/QtVie.text = str(vieBoss)
		$TempsBossAvantAttaque.start()


func _on_temps_boss_avant_attaque_timeout():
	nombreAléatoire = rng.randf_range(0, 1)
	if nombreAléatoire > 0.33333:
		nomBoss.play("attaqueNormal")
	else:
		nomBoss.play("grosseAttaque")
	if queteActuel != "mission4_bc" or nombreAléatoire > 0.33333:
		$TempsDeLattaque.start()
	else:
		$TempsDeLaGrosseAttaqueDePhilipe.start()


func _on_temps_de_lattaque_timeout():
	BossFin()


func TourJoueur():
	$Tuile_boite_de_texte/btnPetiteAttaque.disabled = false
	if joueurInteligence >= 3:
		$Tuile_boite_de_texte/btnGrandeAttaque.disabled = false
	if joueurInteligence >= 7:
		$Tuile_boite_de_texte/btnAttaqueSpecial.disabled = false
		


func TourBoss():
	$Tuile_boite_de_texte/btnAttaqueSpecial.disabled = true
	$Tuile_boite_de_texte/btnGrandeAttaque.disabled = true
	$Tuile_boite_de_texte/btnPetiteAttaque.disabled = true


func _on_btn_fuire_pressed():
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


func _on_btn_petite_attaque_pressed():
	TourBoss()
	$ProjectileJoueur.visible = true;
	AjouterTemps.emit(10)
	$ProjectileJoueur/AnimationPlayer.play("AttaqueNormal")
	$ProjectileJoueur/TimerProjectileNormal.start()


func _on_timer_projectile_timeout():
	BossTouche(10)
	$ProjectileJoueur.visible = false


func _on_temps_de_la_grosse_attaque_de_philipe_timeout():
	BossFin()


func BossFin():
	if nombreAléatoire > 0.33333:
		EnleverVieJoueur.emit(5)
	else:
		EnleverVieJoueur.emit(10)
	nomBoss.play("pasBouger")
	TourJoueur()


func _on_timer_projectile_gros_timeout():
	BossTouche(10)
	BossTouche(10)
	$ProjectileJoueur.visible = false


func _on_btn_grande_attaque_pressed():
	TourBoss()
	AjouterTemps.emit(10)
	$ProjectileJoueur.visible = true;
	$ProjectileJoueur/AnimationPlayer.play("GrosseAttaque")
	$ProjectileJoueur/TimerProjectileGros.start()


func _on_btn_attaque_special_pressed():
	TourBoss()
	AjouterTemps.emit(10)
	$ProjectileJoueur.visible = true;
	$ProjectileJoueur/AnimationPlayer.play("AttaqueSpecial")
	$ProjectileJoueur/TimerProjectileSpecial.start()


func _on_timer_projectile_special_timeout():
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	BossTouche(10)
	$ProjectileJoueur.visible = false

