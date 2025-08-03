extends Node2D
@onready var table:Sprite2D=$TableWithCrossbow
@onready var player:CharacterBody2D=$Player
var inside:bool=false
@onready var scal:CollisionShape2D=$Player/CollisionShape2D
func _ready():

	scal.apply_scale(Vector2(0.4,0.4))

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
		table.texture=load("res://Assets/Armory/tables without cross bow.png")
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inside=true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inside=false
