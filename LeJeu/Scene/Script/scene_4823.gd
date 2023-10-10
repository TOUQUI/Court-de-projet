extends Node2D

signal joueurÉtudieEnClasse(heure:int)

var nodes

func _ready():
	pass 

func ConnecterBureau():
	nodes = get_node("/root/NodeQG/Étude")
	nodes = nodes.get_children()
	for child in nodes:
		if !child.joueurEnClasse.is_connected(GererBureaux):
			child.joueurEnClasse.connect(GererBureaux)


func GererBureaux(heure):
	joueurÉtudieEnClasse.emit(heure)


func _on_sortie_body_entered(body):
	pass 
