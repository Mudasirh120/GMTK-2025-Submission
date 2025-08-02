extends StaticBody2D
@onready var ThrArrow = load("res://Throwables/arrow.tscn")
@onready var cooldown=$CoolDown
var Arrow 
var isColliding:bool
func _ready() -> void:
	cooldown.start()
func _on_cool_down_timeout() -> void:
	Arrow = ThrArrow.instantiate()
	get_tree().get_root().add_child(Arrow)
	getAngle()
	Arrow.global_position=global_position
	Arrow.rotation=global_rotation
	print(".")
	print(Arrow.isCollided)
	print(rotation)
func getAngle():
	if Arrow.rotation==rad_to_deg(180):
		print("!")
		Arrow.targetlocation=Vector2(1,0) 
	elif rotation_degrees==90.0:
		Arrow.targetlocation=Vector2(0,-1)
	elif rotation== 180.0:
		Arrow.targetlocation=Vector2(-1,0)
	elif rotation== 270:
		Arrow.targetlocation=Vector2(0,1) 
		 
		 
		
