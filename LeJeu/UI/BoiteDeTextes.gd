extends Node2D


var queteActuel 
var dialoguesMission
var nbDialogues 
static var jouerDialogue = false
var i = 0
var dialogueDejaJoue = false
var joueur = preload("res://Joueur/joueur.gd")
var joueurNode 
var joueurProvenance
var peuxEtreAffiche = false
var sceneCombat
var actionJoueur
var boss
var parent
var murNode
var optionNode

func _ready():
	joueurProvenance = joueur.derniere_emplacement
	Charger()


func Charger():
	if SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche == false:
		queteActuel = SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel
		if queteActuel == "mission1_bc" && joueurProvenance == "BureauProf":
			peuxEtreAffiche = true
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = true
		elif queteActuel == "mission1_ac" && SingletonsDonnees.dictionaireDesDonnees["DataSession"].bossMort == true:
			peuxEtreAffiche = true
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = true
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].bossMort = false
		elif queteActuel == "mission2_bc" && joueurProvenance == "4823":
			peuxEtreAffiche = true
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = true
		elif queteActuel == "mission2_ac" && SingletonsDonnees.dictionaireDesDonnees["DataSession"].bossMort == true:
			peuxEtreAffiche = true
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = true
		elif (queteActuel == "mission3_bc" || queteActuel == "mission3_ac") && (joueurProvenance == "4923" || joueurProvenance == "Blibli"):
			peuxEtreAffiche = true
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = true
		elif (queteActuel == "mission4_bc" || queteActuel == "mission4_ac") && joueurProvenance == "Cafetreria":
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = true
			if queteActuel == "mission4_bc":
				sceneCombat = find_parent("SceneCombat")
				peuxEtreAffiche = true
			elif queteActuel == "mission4_ac":
				dialoguesMission = SingletonsDonnees.dictionaireDesDonnees[queteActuel]
				nbDialogues = dialoguesMission.size()
				peuxEtreAffiche = true
				jouerDialogue = true
				GererDialogues()
		if peuxEtreAffiche:
			dialoguesMission = SingletonsDonnees.dictionaireDesDonnees[queteActuel]
			nbDialogues = dialoguesMission.size()
			self.visible = true
			jouerDialogue = true
			GererDialogues()
	if peuxEtreAffiche == true:
		parent = self.find_parent("SceneBureauProf")
		if parent == null:
			parent = self.find_parent("SceneCorridorD")
			if parent == null:
				parent = self.find_parent("Scene4823")
		if parent != null:
			optionNode = parent.find_child("MenuPause")
			optionNode.JoueurPeuxPause = false
			murNode = parent.find_child("BlockagePorte")
			murNode.collision_layer = true


func _input(event):
	if event.is_action_pressed("ui_accept") && jouerDialogue:
		if i < (nbDialogues - 1):
			i = i + 1
			GererDialogues()
		elif SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel == "mission4_ac":
			$Nom.text = ""
			$ChampTexte.text = ""
			$MissionReussi.visible = true
			sceneCombat = find_parent("SceneCombat")
			boss = sceneCombat.find_child("Philipe")
			boss = boss.find_child("AnimationPlayer")
			boss.play("mort")
			sceneCombat = sceneCombat.find_child("TimerAvantRetourMenue")
			sceneCombat.start()
		else:
			jouerDialogue = false
			i = 0
			self.visible = false
			SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss = true
			if queteActuel == "mission1_bc":
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission1_ac"
			elif queteActuel == "mission2_bc":
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission2_ac"
			elif queteActuel == "mission3_bc":
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission3_ac"
			elif queteActuel == "mission4_bc":
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission4_ac"
				actionJoueur = sceneCombat.find_child("Boite")
				actionJoueur.visible = true
				actionJoueur = sceneCombat.find_child("labelNode")
				actionJoueur.visible = true
			elif queteActuel == "mission1_ac":
				self.visible = true
				MissionRéussie()
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission2_bc"
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss = true
			elif queteActuel == "mission2_ac":
				self.visible = true
				MissionRéussie()
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission3_bc"
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss = true
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].dialogueDeMissionDejaAffiche = false
			elif queteActuel == "mission3_ac":
				self.visible = true
				MissionRéussie()
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].queteActuel = "mission4_bc"
				SingletonsDonnees.dictionaireDesDonnees["DataSession"].joueurPretBoss = true
			if murNode != null:
				optionNode.JoueurPeuxPause = true
				murNode.collision_layer = false

func MissionRéussie():
	dialogueDejaJoue = true
	$Nom.text = ""
	$ChampTexte.text = ""
	$MissionReussi.visible = true
	$MissionReussi/Timer.start()


func GererDialogues():
	$Nom.text = dialoguesMission[i][0]
	$ChampTexte.text = dialoguesMission[i][1]


func _on_timer_timeout():
	$MissionReussi.visible = false
	self.visible = false
	jouerDialogue = true
