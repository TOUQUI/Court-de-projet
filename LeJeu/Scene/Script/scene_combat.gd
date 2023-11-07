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
var joueur = preload("res://Joueur/joueur.gd")
var boiteDeTexte
var texte = preload("res://UI/boite_de_textes.tscn")


func _ready():
	queteActuel = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	joueurNode = get_node("Joueur")
	joueurInteligence = joueurNode.find_child("Joueur_interface").niveauIntelligence
	$AttaqueSpeciale1.visible = false
	$AttaqueSpeciale2.visible = false
	$ProjectileJoueur.visible = false
	$Personnage/AnimationPlayer.play("Bouger")
	if SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss:
		if queteActuel == "mission1_ac":
			nouvelle_texture = load("res://image/ArièrePlanBoss1.png")
			vieBoss = 100
			vieBossDeBase = vieBoss
			$Ennemie/Jose.visible = true
			nomBoss = get_node("Ennemie/Jose/image/AnimationPlayer")
		elif queteActuel == "mission2_ac":
			nouvelle_texture = load("res://image/ArièrePlanBoss2.png")
			vieBoss = 150
			vieBossDeBase = vieBoss
			$Ennemie/enemie_trois.visible = true
			nomBoss = get_node("Ennemie/enemie_trois/image/AnimationPlayer")
		elif queteActuel == "mission3_ac":
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
			$Boite.visible = false
			$labelNode.visible = false
			nomBoss = get_node("Ennemie/Philipe/image/AnimationPlayer")
		$ArièrePlan.texture = nouvelle_texture
		$BossVie/QtVie.text = str(vieBoss)
		nomBoss.play("pasBouger")
		$ProjectileJoueur.visible = false
		TourJoueur()

func BossTouche(pPointDeViePerdue):
	vieBoss = vieBoss - pPointDeViePerdue
	if vieBoss <= 0:
		$BossVie/TextureProgressBar.value = 0
		$BossVie/QtVie.text = "0"
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].bossMort = true
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss = false
		SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false
		if nomBoss != get_node("Ennemie/Philipe/image/AnimationPlayer"):
			$TimerAvantChangementScene.start()
			$Noir/AnimationPlayer.play("finCombatNormal")
			nomBoss.play("mort")
		else:
			$Boite.visible = false
			$labelNode.visible = false
			boiteDeTexte = self.find_child("BoiteDeTextes")
			self.remove_child(boiteDeTexte)
			texte = texte.instantiate()
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission4_ac"
			self.add_child(texte)
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
	$Boite/Tuile_boite_de_texte/btnPetiteAttaque.disabled = false
	if joueurInteligence >= 3:
		$Boite/Tuile_boite_de_texte/btnGrandeAttaque.disabled = false
	if joueurInteligence >= 7:
		$Boite/Tuile_boite_de_texte/btnAttaqueSpecial.disabled = false



func TourBoss():
	$Boite/Tuile_boite_de_texte/btnAttaqueSpecial.disabled = true
	$Boite/Tuile_boite_de_texte/btnGrandeAttaque.disabled = true
	$Boite/Tuile_boite_de_texte/btnPetiteAttaque.disabled = true


func _on_btn_fuire_pressed():
	AjouterTemps.emit(100)
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


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
	BossTouche(20)
	$ProjectileJoueur.visible = false


func _on_btn_petite_attaque_pressed():
		TourBoss()
		$ProjectileJoueur.visible = true;
		$ProjectileJoueur/AnimationPlayer.play("AttaqueNormal")
		$ProjectileJoueur/TimerProjectileNormal.start()


func _on_btn_grande_attaque_pressed():
	TourBoss()
	$ProjectileJoueur.visible = true;
	$ProjectileJoueur/AnimationPlayer.play("GrosseAttaque")
	$ProjectileJoueur/TimerProjectileGros.start()


func _on_btn_attaque_special_pressed():
	TourBoss()
	$AttaqueSpeciale1/AnimationPlayer.play("Attaque")
	$AttaqueSpeciale2/AnimationPlayer.play("Attaque")
	$AttaqueSpeciale1/TimerProjectileSpecial.start()


func _on_timer_projectile_special_timeout():
	BossTouche(100)
	$ProjectileJoueur.visible = false


func _on_timer_avant_changement_scene_timeout():
	AjouterTemps.emit(100)
	if nomBoss == get_node("Ennemie/Jose/image/AnimationPlayer"):
		get_tree().change_scene_to_file("res://Scene/sceneBureauProf.tscn")
	elif nomBoss == get_node("Ennemie/enemie_trois/image/AnimationPlayer"):
		get_tree().change_scene_to_file("res://Scene/scene_4823.tscn")
	elif nomBoss == get_node("Ennemie/EnnemieUn/image/AnimationPlayer"):
		joueur.derniere_emplacement = "Blibli"
		get_tree().change_scene_to_file("res://Scene/scene_bibliotheque.tscn")


func _on_timer_avant_retour_menue_timeout():
	$fondueNoir.start()
	$BoiteDeTextes.visible = false
	$Noir/AnimationPlayer.play("fin")

func _on_fondue_noir_timeout():
	AjouterTemps.emit(100)
	get_tree().change_scene_to_file("res://Scene/SceneMaison.tscn")

