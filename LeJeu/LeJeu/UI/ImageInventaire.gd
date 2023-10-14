extends Sprite2D

signal InventaireClique

func _input(event):
	if event.is_action_pressed("cliqueGauche"):
		InventaireClique.emit()
