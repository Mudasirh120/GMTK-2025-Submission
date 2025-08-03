extends Node2D
@onready var Almira =$Almira
@onready var viewtable:SubViewportContainer=$Almira/SubViewportContainer
@onready var AlmiraText =$Almira/Label
@onready var DoorText =$Door/Label
@onready var player
@onready var camera:Camera2D=$Camera2D
@onready var meraCamera :Camera2D=get_node("Almira/SubViewportContainer/VCamera")
var clickable=false
@onready var sprite:Sprite2D=$Almira/Sprite2D
@onready var area:CollisionShape2D=$Almira/CollisionShape2D
@onready var main
@onready var doorOpen = load("res://Assets/RoomDoorOpen.png")
@onready var door:Sprite2D = $Door/Sprite2D
func _on_almira_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.CanInteract=true
		AlmiraText.text="Click to interact"
		clickable=true
		player=body
func _on_almira_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		AlmiraText.text=""
		clickable=false
		body.CanInteract=false
func _on_almira_detect_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and clickable:
			enable()
func enable():
	AlmiraText.text=""
	camera.enabled=false
	viewtable.visible=true
	player.isSurrendered=true
	area.disabled=true
	sprite.visible=false
	meraCamera.enabled=true
func disable():
	AlmiraText.text=""
	camera.enabled=true
	viewtable.visible=false
	player.isSurrendered=false
	area.disabled=false
	sprite.visible=true
	meraCamera.enabled=false
	

func _on_door_open_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player=body
		DoorText.text= "Click to Open"
func _on_door_open_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		DoorText.text= ""


func _on_door_open_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and player.hasKey:
		door.texture=doorOpen
