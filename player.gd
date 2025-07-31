extends CharacterBody2D
const SPEED:int=100
var Health:int= 100
var Stamina :float= 1.0
var totalCommulativeSpeed=1
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left",'move_right','move_forward',"move_backward")
	if Input.is_action_pressed("run"):
		totalCommulativeSpeed = (SPEED * 2) * Stamina
	elif Input.is_action_pressed('sneak'):
		totalCommulativeSpeed = SPEED * 0.5
	else:
		totalCommulativeSpeed = SPEED 
	velocity= direction*totalCommulativeSpeed
	move_and_slide()
