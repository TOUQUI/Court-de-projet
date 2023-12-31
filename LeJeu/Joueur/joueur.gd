extends CharacterBody2D

@export var VITESSE_MAX = 65
@export var ACCELERATION = 200
@export var FRICTION = 600
@onready var axis =Vector2.ZERO

signal joueur_étudie_en_classe(heure:int)
signal joueur_travail(salaire:int)
signal joueur_étudie(heure:int)
signal enleverVie(valeur:int)
signal ajouterItemAcheter(item:int, prix:int)
signal ajouterVieRetirerArgent(vie:int, prix:int)
signal envoieHeure(temps:int)
signal demanderHeure()
signal dormir()
signal sauvegarder()
signal joueurAttaque(valeur:int)

static var derniere_emplacement = "vide"

var emplacementActuel = ""
var positionX
var positionY
var parent_node
var nodes

func _ready():
	_input(input_event)
	if derniere_emplacement == "Menu":
		derniere_emplacement == ""
		gererEmplacement()
	if derniere_emplacement == "GP" || emplacementActuel == "res://Scene/node_SceneQG.tscn":
		Connecter_bureaux()

func _physics_process(delta):
	bouger(delta)


func gererEmplacement():
		positionX = SingletonsDonnees.dictionaireDesDonnees["DataSession"].x
		positionY = SingletonsDonnees.dictionaireDesDonnees["DataSession"].y
		if positionX != -69 || positionY != -69:
			self.position = Vector2(positionX, positionY)


func _input(event):
	
	if Input.is_action_just_pressed("bas"):
		velocity = Vector2.ZERO
		ACCELERATION = 1500
	elif Input.is_action_just_pressed("haut"):
		velocity = Vector2.ZERO
		ACCELERATION = 1500
	elif Input.is_action_just_pressed("droite"):
		velocity = Vector2.ZERO
		ACCELERATION = 1500
	elif Input.is_action_just_pressed("gauche"):
		velocity = Vector2.ZERO
		ACCELERATION = 1500
	
	if Input.is_action_pressed("bas"):
		$AnimationPlayer.play("avancer_bas")
	elif Input.is_action_pressed("droite"):
		$AnimationPlayer.play("avancer_droite")
	elif Input.is_action_pressed("gauche"):
		$AnimationPlayer.play("avancer_gauche")
	elif Input.is_action_pressed("haut"):
		$AnimationPlayer.play("avancer_haut")
	else:
		$AnimationPlayer.play("pas_bouger")
	
	if Input.is_action_pressed("courire"):
		VITESSE_MAX = 250
	else:
		VITESSE_MAX = 100

func attraper_la_touche():
	axis.x = int(Input.is_action_pressed("droite")) - int(Input.is_action_pressed("gauche"))
	axis.y = int(Input.is_action_pressed("bas")) - int(Input.is_action_pressed("haut"))
	return axis .normalized()


func bouger(delta):
	axis = attraper_la_touche()
	
	if axis == Vector2.ZERO:
		apliquer_friction(FRICTION * (delta + 0.05))
	else:
		apliquer_mouvement(axis * ACCELERATION * delta)
	move_and_slide()


func apliquer_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount 
	else:
		velocity = Vector2.ZERO


func apliquer_mouvement(accel):
	velocity += accel
	velocity = velocity.limit_length(VITESSE_MAX)


func Connecter_bureaux():
	nodes = get_node("/root/NodeQG/Étude")
	if nodes != null:
		nodes = nodes.get_children()
		for child in nodes:
			if !child.joueur_étudie.is_connected(EnleverTemps):
				child.joueur_étudie.connect(EnleverTemps)


func EnleverTemps(heure, expediteur):
	nodes = get_node("/root/NodeQG/Étude/" + str(expediteur))
	if !nodes.joueur_étudie.is_connected(EnleverTemps):
		nodes.joueur_étudie.connect(EnleverTemps)
	joueur_étudie.emit(20)


func _on_vendeur_du_qg_acheter(item, prix):
	ajouterItemAcheter.emit(item, prix)


func _on_scene_caféteria_acheter_café(item, prix):
	ajouterItemAcheter.emit(item, prix)


func _on_menu_pause_sauvegarder():
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].x = self.position.x
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].y = self.position.y
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].emplacementSauvegarde = emplacementActuel
	sauvegarder.emit()


func _on_scene_maison_dormir():
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].x = self.position.x
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].y = self.position.y
	SingletonsDonnees.dictionaireDesDonnees["DataSession"].emplacementSauvegarde = emplacementActuel
	dormir.emit()


func _on_scene_travail_travailler(salaire):
	joueur_travail.emit(salaire)


func _on_scene_4823_joueurétudie_en_classe(heure):
	pass


func _on_scene_combat_enlever_vie_joueur(valeur):
	enleverVie.emit(valeur)


func _on_scene_travail_joyeux_repas_sur_place(vie, prix):
	ajouterVieRetirerArgent.emit(vie, prix)


func _on_scene_travail_joyeux_repas_emporter(item, prix):
	ajouterItemAcheter.emit(item, prix)


func _on_scene_combat_ajouter_temps(valeur):
	joueurAttaque.emit(valeur)


func _on_scene_caféoxymel_achat_café(item, prix):
	ajouterItemAcheter.emit(item, prix)
