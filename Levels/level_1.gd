extends Node2D
@onready var Almira =$Almira
@onready var viewtable:SubViewportContainer=$Almira/SubViewportContainer
@onready var DoorCollision = $Door/DoorStopper
@onready var player
@onready var camera:Camera2D=$Player/Camera2D
@onready var meraCamera :Camera2D=get_node("Almira/SubViewportContainer/VCamera")
var clickable=false
@onready var sprite:Sprite2D=$Almira/Sprite2D
@onready var area:CollisionShape2D=$Almira/CollisionShape2D
@onready var main
@onready var doorOpen = load("res://Assets/RoomDoorOpen.png")
var doorstate:bool=false
@onready var door:Sprite2D = $Door/Sprite2D
@onready var nextLevelGoing = load("res://Scenes/next_level.tscn")
func _on_almira_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.CanInteract=true
		clickable=true
		player=body
func _on_almira_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		clickable=false
		body.CanInteract=false
func _on_almira_detect_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and clickable:
			enable()
func enable():
	camera.enabled=false
	viewtable.visible=true
	player.isSurrendered=true
	area.disabled=true
	sprite.visible=false
	meraCamera.enabled=true
func disable():
	camera.enabled=true
	viewtable.visible=false
	player.isSurrendered=false
	area.disabled=false
	sprite.visible=true
	meraCamera.enabled=false
func _on_door_open_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player=body
func _on_door_open_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pass

func _on_door_open_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and player.hasKey:
		door.texture=doorOpen
		doorstate=true
		DoorCollision.disabled=true
		var nextLevel = nextLevelGoing.instantiate()
		door.add_child(nextLevel)
		
