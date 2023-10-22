extends Sprite2D

signal acheter(item:int, prix:int)

var joueur_dans_zone = false
var parent
var joueur_node

func _ready():
	$F.visible = false
	$CanvasLayer/Menu.visible = false
	$CanvasLayer/Magasin.visible = false


func _on_la_zone_de_vente_body_entered(body):
	joueur_dans_zone = true
	$F.visible = true


func _on_la_zone_de_vente_body_exited(body):
	joueur_dans_zone = false
	$F.visible = false
	$CanvasLayer/Menu.visible = false
	$CanvasLayer/Magasin.visible = false


func _input(event):
	if event.is_action_pressed("interaction") && joueur_dans_zone:
		$CanvasLayer/Menu.visible = true

func _on_magasin_pressed():
	$CanvasLayer/Menu.visible = false
	$CanvasLayer/Magasin.visible = true


func _on_quiter_pressed():
	$CanvasLayer/Menu.visible = false


func _on_btn_acheter_boison_pressed():
	acheter.emit(1,5)


func _on_button_pressed():
	$CanvasLayer/Magasin.visible = false
