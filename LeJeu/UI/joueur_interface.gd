extends CanvasLayer

var temps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_joueur_btn_qg():
	temps = temps + 10
	$Node2D/TextureProgressBar.value = temps
