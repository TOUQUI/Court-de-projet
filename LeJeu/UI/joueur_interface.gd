extends CanvasLayer

var temps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_joueur_joueur_étudie(heure):
	temps =  temps + heure
	$Node2D/TextureProgressBar.value = temps
