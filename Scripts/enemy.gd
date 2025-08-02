extends CharacterBody2D
@onready var Agent:NavigationAgent2D=$Follow
@onready var Ray:RayCast2D=$RayCast2D
@onready var VisDetect:=$VisualDetect
@onready var soun: CollisionShape2D=$SoundDetect/sound
@onready var sontim: Timer=$SoundDetect/sontim
@onready var healthbar:Label=$Health
@onready var Player:CharacterBody2D= get_parent().get_node("Player")
const SPEED:int=100
var Health:int= 100
var heard:bool=false
var stillcansee:bool=false
var isFollowing=false
var lastSeenPos:Vector2
var direction:Vector2
var lastheard:Vector2
var tims:bool=false
var dist
var explicitPositions:Array
var ExplicitPosition:Vector2
func _ready() -> void:
	Ray.enabled=true
func _on_visual_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		stillcansee=true
		isFollowing=true
		body.isSeen = true
func sortPositions():
	explicitPositions.sort_custom(func(a,b): return a[1]< b[1] )
func _physics_process(delta: float):
	if explicitPositions!=[]:
		sortPositions()
		print(explicitPositions)
		Agent.target_position=explicitPositions[0]
		if not Agent.is_navigation_finished():
			direction = (Agent.get_next_path_position() - global_position).normalized()
			velocity = direction * SPEED
			move_and_slide()	
		else:
			explicitPositions.pop_front()
	Ray.global_rotation_degrees=0
	if tims==true:
		soun.disabled=true
	if heard:
		followvoice()
		direction = (Agent.get_next_path_position() - global_position).normalized()
		velocity = direction * SPEED
	elif !heard:
		velocity = Vector2.ZERO
	if isFollowing and Player.isSeen:
		Ray.target_position=Player.global_position-global_position
		heard=false
		if stillcansee:
			FollowPlayer()
		if Ray.is_colliding() and Ray.get_collider() != Player || dist >700:
			stillcansee = false
			GoToLastSeen()
		if not Agent.is_navigation_finished():
			direction = (Agent.get_next_path_position() - global_position).normalized()
			velocity = direction * SPEED
		else:
			velocity = Vector2.ZERO
			lookArround()
	move_and_slide()

func _on_sound_detect_area_entered(area: Area2D):
	if !stillcansee:
		if area.is_in_group("splayer"):
			Agent.target_position=Player.global_position
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
		dist=Agent.distance_to_target()
		lastSeenPos=Player.global_position
func GoToLastSeen():
	Agent.target_position = lastSeenPos
func lookArround():
	print("Kahan dekhna")
	VisDetect.rotation += deg_to_rad(45) * get_process_delta_time()
func _on_sontim_timeout() -> void:
	tims=false
	global_rotation_degrees=0
	soun.disabled=false




func gotHit():
	Health-=33
	healthbar.text=str(Health)
	if(Health<=0):
		die()
func die():
	queue_free()
