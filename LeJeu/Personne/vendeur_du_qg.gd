extends Sprite2D

signal travailler()

var joueur_dans_zone = false
var parent
var joueur_node

func _ready():
	$Personnage_interface.visible = false
	$F.visible = false


func _on_la_zone_de_vente_body_entered(body):
	joueur_dans_zone = true
	$F.visible = true


func _on_la_zone_de_vente_body_exited(body):
	joueur_dans_zone = false
	$Personnage_interface.visible = false
	$F.visible = false


func _input(event):
	if event.is_action_pressed("interaction") && joueur_dans_zone:
		$Personnage_interface.visible = true

func _on_personnage_interface_btn_click():
	travailler.emit()
