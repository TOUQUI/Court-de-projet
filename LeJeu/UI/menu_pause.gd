extends Node2D

signal sauvegarder()

var JoueurPeuxPause = true

func _ready():
	$Menu.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if ($Menu.visible == false && JoueurPeuxPause):
			$Menu.visible = true
		else:
			$Menu.visible = false

func _on_btn_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/menu_principale.tscn")


func _on_btn_sauvegarder_button_down():
	sauvegarder.emit()


func _on_btn_retour_button_down():
	$Menu.visible = false
