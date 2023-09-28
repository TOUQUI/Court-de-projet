extends Panel

signal clique_gauche(id:int)

var dejaClique = false

func _on_gui_input(event):
	if event.is_action_released("cliqueGauche") && !dejaClique:
		clique_gauche.emit(self.name)
