extends Node2D

var queteActuel 
var dialogueEnCours = 0

func _ready():
	queteActuel = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	if queteActuel == 1:
		Mission1()


func _process(delta):
	pass

func Mission1():
