extends CharacterBody2D

@export var VITESSE_MAX = 200
@export var ACCELERATION = 1500
@export var FRICTION = 500
@onready var axis =Vector2.ZERO

signal joueur_étudie(heure:int)

static var derniere_emplacement = "vide"

var parent_node
var nodes

func _ready():
	if derniere_emplacement == "GP":
		Connecter_bureaux()

func _physics_process(delta):
	bouger(delta)


func _input(event):
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
		VITESSE_MAX = 450
	else:
		VITESSE_MAX = 200


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
	nodes = nodes.get_children()
	for child in nodes:
		if !child.joueur_étudie.is_connected(EnleverTemps):
			child.joueur_étudie.connect(EnleverTemps)


func EnleverTemps(heure, expediteur):
	nodes = get_node("/root/NodeQG/Étude/" + str(expediteur))
	if !nodes.joueur_étudie.is_connected(EnleverTemps):
		nodes.joueur_étudie.connect(EnleverTemps)
	joueur_étudie.emit(20)
