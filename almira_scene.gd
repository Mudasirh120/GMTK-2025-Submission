extends SubViewportContainer
@onready var almari:StaticBody2D=$SubViewport/Almira_scene
@onready var pickup =$SubViewport/Pick/CollisionShape2D
@onready var almariImg=load("res://Assets/Princess room/Cabinet1.png")
@onready var almari1Img=load("res://Assets/Princess room/open1.png")
@onready var almari2Img=load("res://Assets/Princess room/open2.png")
@onready var almari3Img=load("res://Assets/Princess room/open3.png")
@onready var keyImage=load("res://Assets/Princess room/key.png")
@onready var key=$SubViewport/Almira_scene/Sprite2D2
@onready var Sprite =$Sprite2D
@onready var pickedImage = load("res://Assets/OpenCupboard1.png")
@onready var sprite:Sprite2D=$SubViewport/Almira_scene/Sprite2D
@onready var btn = $SubViewport/Almira_scene/Button
@onready var lvl1:Node2D = get_parent().get_parent()
@onready var plyr:CharacterBody2D=get_parent().get_parent().get_node("Player")
func _ready() -> void:
	pickup.disabled=true
	sprite.texture=almariImg
	key.visible=false
	
func _on_button_pressed() -> void:
	pickup.disabled=true
	sprite.texture=almariImg
	lvl1.disable()

func one_on__pressed() -> void:
	pickup.disabled=true
	sprite.texture=almari1Img
	key.visible=false


func two_on__pressed() -> void:
	if key.visible:
		print("Oye hogya")
		pickup.disabled=false
		plyr.hasKey=true
		key.visible=false
		key.texture=null
	else:
		key.texture=null
		key.texture=keyImage
		pickup.disabled=false
		sprite.texture=almari2Img
		key.visible=true
		plyr.hasKey=false

	


func three_on__pressed() -> void:
	pickup.disabled=true
	sprite.texture=almari3Img
	key.visible=false


	
