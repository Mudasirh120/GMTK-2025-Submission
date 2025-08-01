extends CharacterBody2D
@onready var label:Label=$Label
var clickable=true
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text="Click to interact"
		body.CanInteract=true
		clickable=true
		print("Player hi hoon mein")
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text=""
		body.CanInteract=false
		clickable=false
		print("Player tha mein")


#func _on_area_2d_mouse_entered() -> void:
	

#func _on_area_2d_mouse_exited() -> void:


func _on_button_pressed() -> void:
	if clickable:
		get_tree().quit() 
