extends CharacterBody2D
@onready var RunningTimer:Timer = $RunningTimer
@onready var StaminaText:Label = $Stamina
@onready var HealthText:Label = $Health
@onready var TotalSpeed:Label = $TotalSpeed
@onready var AttackArea:Area2D=$Attack
@onready var EnemyHitArea:Area2D= get_parent().get_node("Enemy").get_node("HitBox")
@onready var Enemy:CharacterBody2D= get_parent().get_node("Enemy")
@onready var att:CollisionPolygon2D=$Attack/attackbox
@onready var soun:CollisionShape2D=$Sound/CollisionShape2D
@onready var attackcooldown:Timer=$attcooldown
var attcool:bool=false
var base:Vector2
var direction 
const SPEED:int=100
var Health:int= 100
var isRunning: bool
var Stamina :float= 1.0
var totalCommulativeSpeed=1
var dodgeDashAvailable:bool
var isSurrendered:bool=false
func _ready() -> void:
	isRunning=false
	dodgeDashAvailable= true
	RunningTimer.start()
	print(EnemyHitArea)
	print(Enemy)
	base=Vector2(1.0,1.0)
func _physics_process(delta: float) -> void:
	soun.scale=base
	soun.disabled=true
	att.disabled=true
	if !isSurrendered:
		if Input.is_action_pressed("Attack") and attcool==false:
			attcool=true
			attackcooldown.start()
			soun.disabled=false
			att.disabled=false
			soun.scale*=3
			
		direction = Input.get_vector("move_left",'move_right','move_forward',"move_backward")
		if direction:
			soun.disabled=false
		attackdir()
		if Input.is_action_pressed("run"):
			if direction != Vector2():
				if direction:
					soun.scale*=2
				isRunning=true
				totalCommulativeSpeed = (SPEED * 2) * Stamina
		elif Input.is_action_pressed('sneak'):
			totalCommulativeSpeed = SPEED * 0.3
			if direction:
				soun.scale/=3
		elif Input.is_action_just_released("dash"):
			if dodgeDashAvailable:
				dodgeDashAvailable=false
				dodgeDash()
		else:
			isRunning=false
			totalCommulativeSpeed = SPEED 
		velocity= direction*totalCommulativeSpeed
		StaminaText.text=str(Stamina)
		TotalSpeed.text=str(totalCommulativeSpeed)
		HealthText.text=str(Health)
		if(Health <50):
			Surrender()
		move_and_slide()

func _on_running_timer_timeout() -> void:
	if isRunning:
		Stamina-=0.1
	else:
		Stamina+=0.1
	Stamina=clamp(Stamina,0.5,1)
	if Stamina==1.0:
		dodgeDashAvailable=true
func Surrender():
	totalCommulativeSpeed=0
	isSurrendered=true

func dodgeDash():
		totalCommulativeSpeed=SPEED*100
		Stamina-=0.6
		soun.disabled=false
		soun.scale*=3
func attackdir():
	if direction.y>0:
		att.rotation=90
	elif direction.y<0:
		att.rotation=-90
	elif direction.x<0:
		att.rotation=180
	elif direction.x>0:
		att.rotation=0
func _on_attack_area_entered(area: Area2D) -> void:
	if area == EnemyHitArea:
		Enemy.gotHit()






















var isSeen=false


func _on_attcooldown_timeout() -> void:
	attcool=false
