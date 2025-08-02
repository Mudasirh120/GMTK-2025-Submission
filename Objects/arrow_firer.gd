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
	getAngle(rotation_degrees)
	Arrow.global_position=global_position
	Arrow.rotation=rotation
	print(".")
	print(Arrow.isCollided)
	
func getAngle(rots:int):
	
	print(rots)
	
	if rots==0:
		Arrow.targetlocation=Vector2(1,0) 
	elif rots==90:
		Arrow.targetlocation=Vector2(0,1)
	elif rots== 180:
		Arrow.targetlocation=Vector2(-1,0)
	elif rots== -90:
		Arrow.targetlocation=Vector2(0,-1) 
	else:
		getAngle(rots+1)
		 
		 
		
