extends CharacterBody2D
@onready var label:Label=$Label
@onready var viewtable:SubViewportContainer=$SubViewportContainer
@onready var sprite:Sprite2D=$Sprite2d
@onready var area:CollisionShape2D=$CollisionShape2D
@onready var player
var clickable=false
var camera
@onready var meraCamera = get_node("SubViewportContainer").get_node("Camera")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text="Click to interact"
		body.CanInteract=true
		clickable=true
		player=body
		camera=player.get_node("Camera2D")
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text=""
		body.CanInteract=false
		clickable=false
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and clickable:
			label.text=""
			camera.enabled=false
			viewtable.visible=true
			player.isSurrendered=true
			area.disabled=true
			sprite.visible=false
			meraCamera.enabled=true
