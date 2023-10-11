extends Node2D

var queteActuel 
var dialoguesMission
var nbDialogues 
var jouerDialogue = false
var i = 0

func _ready():
	queteActuel = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
	if queteActuel == 1:
		dialoguesMission = SingletonsDonnees.dictionaireDesDonnees["mission1"]
		nbDialogues = dialoguesMission.size()
		jouerDialogue = true
		GererDialogues()


func _input(event):
	if event.is_action_pressed("ui_accept") && jouerDialogue:
		if i < (nbDialogues - 1):
			i = i + 1
			GererDialogues()
		else:
			$BoiteDeTexte.visible = false


func GererDialogues():
	$BoiteDeTexte/Nom.text = dialoguesMission[i][0]
	$BoiteDeTexte/ChampTexte.text = dialoguesMission[i][1]

