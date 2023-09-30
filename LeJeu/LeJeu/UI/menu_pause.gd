extends Node2D

signal sauvegarder()

func _ready():
	$Menu.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Menu.visible == false:
			$Menu.visible = true
		else:
			$Menu.visible = false


func _on_btn_menu_pressed():
	pass 


func _on_btn_sauvegarder_button_down():
	sauvegarder.emit()


func _on_btn_retour_button_down():
	$Menu.visible = false
