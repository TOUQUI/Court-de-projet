extends Sprite2D

var jouer_dans_zone = false

func _ready():
	$F.visible = false


func _on_la_zone_de_vente_body_entered(body):
	jouer_dans_zone = true
	$F.visible = true


func _on_la_zone_de_vente_body_exited(body):
	jouer_dans_zone = false
	$F.visible = false
