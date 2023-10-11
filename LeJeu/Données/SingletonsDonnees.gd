extends Node

var dictionaireDesDialogues = {}
var dialoguesChemain = "user://Dialogues.json"
var dictionaireDesDonnees = {}
var donneesChemain = "user://LesDonnées.json"
var dossier
var convertion

func _ready():
	dictionaireDesDonnees = ChargerJson(donneesChemain)
	dictionaireDesDialogues = ChargerJson(dialoguesChemain)

func ChargerJson(chemain : String):
	if FileAccess.file_exists(chemain):
		dossier = FileAccess.open(chemain, FileAccess.READ)
		convertion = JSON.parse_string(dossier.get_as_text())
		if convertion is Dictionary:
			dossier.close()
			return convertion
	else:
		dossier = FileAccess.open("res://Données/LesDonnées.json", FileAccess.READ)
		convertion = JSON.parse_string(dossier.get_as_text())
		dossier.close()
		dossier = FileAccess.open(donneesChemain, FileAccess.WRITE)
		dossier.store_string(str(convertion))
		dossier.close()
		return convertion

func SauvegarderJson():
	if FileAccess.file_exists(donneesChemain):
		dossier = FileAccess.open(donneesChemain, FileAccess.WRITE)
		dossier.store_string(str(dictionaireDesDonnees))
		dossier.close()
