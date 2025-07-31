extends CharacterBody2D
@onready var timer:Timer = $Timer
@onready var StaminaText:Label = $Stamina
@onready var TotalSpeed:Label = $TotalSpeed
const SPEED:int=100
var Health:int= 100
var isRunning: bool
var Stamina :float= 1.0
var totalCommulativeSpeed=1
var dodgeDashAvailable:bool
func _ready() -> void:
	isRunning=false
	dodgeDashAvailable= true
	timer.start()
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left",'move_right','move_forward',"move_backward")
	print(direction)
	if Input.is_action_pressed("run"):
		if direction != Vector2():
			isRunning=true
			totalCommulativeSpeed = (SPEED * 2) * Stamina
	elif Input.is_action_pressed('sneak'):
		totalCommulativeSpeed = SPEED * 0.3
	elif Input.is_action_just_released("dash"):
		if dodgeDashAvailable:
			dodgeDashAvailable=false
			totalCommulativeSpeed = (SPEED * 60)
			Stamina-=0.6
	else:
		isRunning=false
		totalCommulativeSpeed = SPEED 
	velocity= direction*totalCommulativeSpeed
	move_and_slide()
	StaminaText.text=str(Stamina)
	TotalSpeed.text=str(totalCommulativeSpeed)
	


func _on_timer_timeout() -> void:
	if isRunning:
		Stamina-=0.1
	else:
		Stamina+=0.1
	Stamina=clamp(Stamina,0.5,1)
	if Stamina==1.0:
		dodgeDashAvailable=true
