extends CharacterBody2D
@onready var timer:Timer = $Timer
@onready var label:Label = $Label
const SPEED:int=100
var Health:int= 100
var isRunning: bool = false
var Stamina :float= 1.0
var totalCommulativeSpeed=1

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left",'move_right','move_forward',"move_backward")
	timer.start()
	if Input.is_action_pressed("run"):
		isRunning=true
		totalCommulativeSpeed = (SPEED * 2) * Stamina
	elif Input.is_action_pressed('sneak'):
		totalCommulativeSpeed = SPEED * 0.5
	else:
		totalCommulativeSpeed = SPEED 
	velocity= direction*totalCommulativeSpeed
	isRunning=false
	move_and_slide()
	label.text=str(Stamina)


func _on_timer_timeout() -> void:
	if isRunning:
		Stamina-=0.1
	else:
		Stamina+=0.1
	Stamina=clamp(Stamina,0.1,1)
