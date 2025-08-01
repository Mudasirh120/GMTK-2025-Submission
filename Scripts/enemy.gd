extends CharacterBody2D
const SPEED:int=100
var Health:int= 100
@onready var healthbar:Label=$Health
func gotHit():
	Health-=1
	healthbar.text=str(Health)

































@onready var Agent:NavigationAgent2D=$Follow
@onready var Ray:RayCast2D=$RayCast2D
@onready var VisDetect:=$VisualDetect
@onready var soun: CollisionShape2D=$SoundDetect/sound
@onready var sontim: Timer=$SoundDetect/sontim
var heard:bool=false
var stillcansee:bool=false
var Player:CharacterBody2D
var isFollowing=false
var lastSeenPos:Vector2
var direction:Vector2
var lastheard:Vector2
var tims:bool=false
func _ready() -> void:
	Ray.enabled=true
func _on_visual_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		stillcansee=true
		isFollowing=true
		body.isSeen = true
		Player=body
func _physics_process(delta: float):
	Ray.global_rotation_degrees=0
	if tims==true:
		soun.disabled=true
	if heard:
		
		followvoice()
		
		direction = (Agent.get_next_path_position() - global_position).normalized()
		velocity = direction * SPEED
	if isFollowing and Player.isSeen:
		Ray.target_position=Player.global_position-global_position
		heard=false
		if stillcansee:
			FollowPlayer()
		if Ray.is_colliding() and Ray.get_collider() != Player:
			stillcansee = false
			GoToLastSeen()
		if not Agent.is_navigation_finished():
			direction = (Agent.get_next_path_position() - global_position).normalized()
			velocity = direction * SPEED
		else:
			velocity = Vector2.ZERO
			lookArround()
			
	elif !heard:
		velocity = Vector2.ZERO
	move_and_slide()
var dist

func _on_sound_detect_area_entered(area: Area2D):
	if !stillcansee:
		if area.is_in_group("splayer"):
			Agent.target_position=area.global_position
			dist=Agent.distance_to_target()
			print(dist)
			if dist <700:
				sontim.start()
				tims=true
				lastheard=area.global_position
				look_at(area.global_position)
			if dist <500:
				heard=true
func followvoice():
	Agent.target_position=lastheard
	
func FollowPlayer():
		Agent.target_position = Player.global_position
		lastSeenPos=Player.global_position
		GoToLastSeen()
func GoToLastSeen():
	Agent.target_position = lastSeenPos
func lookArround():
	print("Kahan dekhna")
	VisDetect.rotation += deg_to_rad(45) * get_process_delta_time()


func _on_sontim_timeout() -> void:
	tims=false
	soun.disabled=false
