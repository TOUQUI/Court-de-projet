extends CanvasLayer

signal btn_click

func _on_button_pressed():
	btn_click.emit()
