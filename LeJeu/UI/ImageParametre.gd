extends Sprite2D

signal parametreClique

func _input(event):
	if event.is_action_pressed("cliqueGauche"):
		parametreClique.emit()
