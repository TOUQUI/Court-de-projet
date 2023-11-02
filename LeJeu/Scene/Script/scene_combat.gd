extends Node2D


signal EnleverVieJoueur(valeur:int)

const ennemie = ["EnnemieUn", "EnnemieDeux"]
var auTourDuJoueur = true
var vieBoss = 100
var nombreAléatoire = 0
var rng = RandomNumberGenerator.new()


func _ready():
	TourJoueur()
	$Ennemie/EnnemieUn/image/Animation.play("pasBouger")

func BossTouche(pPointDeViePerdue):
	vieBoss = vieBoss - pPointDeViePerdue
	if vieBoss <= 0:
		$Ennemie/EnnemieUn/image/Animation.play("mort")
		$BossVie/TextureProgressBar.value = 0
		$BossVie/QtVie.text = "0"
	else:
		$BossVie/TextureProgressBar.value = $BossVie/TextureProgressBar.value - ((75 * pPointDeViePerdue) / 100) 
		$BossVie/QtVie.text = str(vieBoss)
		$TempsBossAvantAttaque.start()


func _on_temps_boss_avant_attaque_timeout():
	nombreAléatoire = rng.randf_range(0, 1)
	print(nombreAléatoire)
	if nombreAléatoire > 0.33333:
		#$"Ennemie/Philipe/AngelAppear-sheet/AnimationPlayer".play("attaqueNormal")
		#$Ennemie/Jose/Boss/AnimationPlayer.play("attaqueNormal")
		$Ennemie/EnnemieUn/image/Animation.play("attaqueNormal")
	else:
		#$"Ennemie/Philipe/AngelAppear-sheet/AnimationPlayer".play("grosseAttaque")
		#$Ennemie/Jose/Boss/AnimationPlayer.play("grosseAttaque")
		$Ennemie/EnnemieUn/image/Animation.play("grosseAttaque")
	$TempsDeLattaque.start()


func _on_temps_de_lattaque_timeout():
	if nombreAléatoire > 0.33333:
		EnleverVieJoueur.emit(5)
	else:
		EnleverVieJoueur.emit(10)
	$Ennemie/EnnemieUn/image/Animation.play("pasBouger")
	TourJoueur()


func TourJoueur():
	$Tuile_boite_de_texte/btnAttaqueSpecial.disabled = false
	$Tuile_boite_de_texte/btnGrandeAttaque.disabled = false
	$Tuile_boite_de_texte/btnPetiteAttaque.disabled = false


func TourBoss():
	$Tuile_boite_de_texte/btnAttaqueSpecial.disabled = true
	$Tuile_boite_de_texte/btnGrandeAttaque.disabled = true
	$Tuile_boite_de_texte/btnPetiteAttaque.disabled = true


func _on_btn_fuire_pressed():
	get_tree().change_scene_to_file("res://Scene/SceneCorridorM.tscn")


func _on_btn_petite_attaque_pressed():
	TourBoss()
	$ProjectileJoueur.visible = true;
	$ProjectileJoueur/AnimationPlayer.play("AttaquerBoss")
	$ProjectileJoueur/TimerProjectile.start()


func _on_timer_projectile_timeout():
	BossTouche(10)
	$ProjectileJoueur.visible = false

