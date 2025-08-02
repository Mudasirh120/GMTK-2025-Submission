extends CharacterBody2D
@onready var button =$Sprite2D/Button
@onready var scr =get_parent().get_parent().get_parent().get_parent().get_node("Table")
@onready var meraCamera=get_parent().get_parent().get_node("Camera")
func _on_button_pressed() -> void:
	scr.camera.enabled=true
	scr.viewtable.visible=false
	scr.player.isSurrendered=false
	scr.area.disabled=false
	scr.sprite.visible=true
	meraCamera.enabled=false
	print(meraCamera)
	print(scr)
