extends CharacterBody2D
@onready var label:Label=$Label
var clickable=false
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







func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and clickable:
			get_tree().quit()
