extends SubViewportContainer
@onready var almari:StaticBody2D=$SubViewport/Almira_scene
@onready var Sprite =$Sprite2D
@onready var pickedImage = load("res://Assets/OpenCupboard1.png")
@onready var sprite:Sprite2D=$SubViewport/Almira_scene/Sprite2D
@onready var btn = $SubViewport/Almira_scene/Button
@onready var lvl1:Node2D = get_parent().get_parent()
@onready var plyr:CharacterBody2D=get_parent().get_parent().get_node("Player")
func _ready() -> void:
	print(lvl1)
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
			sprite.texture = pickedImage
			plyr.hasKey=true
			print(plyr.hasKey)


func _on_area_2d_mouse_entered() -> void:
	print("click")


func _on_button_pressed() -> void:
	lvl1.disable()
