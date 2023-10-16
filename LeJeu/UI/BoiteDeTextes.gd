extends Node2D

var queteActuel 
var dialoguesMission
var nbDialogues 
static var jouerDialogue = false
var i = 0

func _ready():
	queteActuel = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	dialoguesMission = SingletonsDonnees.dictionaireDesDonnees[queteActuel]
	nbDialogues = dialoguesMission.size()
	self.visible = true
	jouerDialogue = true
	GererDialogues()


func _input(event):
	if event.is_action_pressed("ui_accept") && jouerDialogue:
		if i < (nbDialogues - 1):
			i = i + 1
			GererDialogues()
		else:
			i = 0
			self.visible = false


func GererDialogues():
	$Nom.text = dialoguesMission[i][0]
	$ChampTexte.text = dialoguesMission[i][1]
