extends CharacterBody2D
enum EnemyState { PATROL, FOLLOW}
var EnemTask:EnemyState = EnemyState.PATROL
@onready var Agent:NavigationAgent2D=$Follow
var direction:Vector2
const SPEED= 100
@onready var StartNode=$"../PatrolPoint1"
@onready var EndNode=$"../PatrolPoint2"
@onready var Ray:RayCast2D=$RayCast2D
@onready var VisDetect:=$VisualDetect
@onready var Player=get_parent().get_node('Player')
var StartPoint:Vector2
var EndPoint:Vector2
var PlayerSeen:bool=false
var PlayerHeard:bool=false
var distance
func _ready() -> void:
	StartPoint=StartNode.global_position
	global_position = StartPoint
	EndPoint=EndNode.global_position
	Agent.target_position = EndPoint
var dir:bool=false
func Patrol():
	if Agent.is_navigation_finished():
		if dir:
			Agent.target_position=StartPoint
			dir=!dir
		else:
			Agent.target_position=EndPoint
			dir=!dir
func follow():
	if !PlayerHeard:
		Ray.target_position=(Player.global_position)
		Ray.force_raycast_update()
		Agent.target_position=Ray.target_position
		if Ray.is_colliding() || distance>=1500:
			PlayerSeen=false
	else:
		Agent.target_position =Ray.target_position
func _physics_process(delta: float):
	if Agent.is_navigation_finished():
		PlayerHeard=false
		PlayerSeen=false
	distance=Agent.distance_to_target()
	if PlayerHeard || PlayerSeen:
		EnemTask= EnemyState.FOLLOW
	else :
		EnemTask= EnemyState.PATROL
	if PlayerSeen:
		PlayerHeard=false
	
	match EnemTask:
		EnemyState.PATROL:
			Patrol()
			direction = (Agent.get_next_path_position() - global_position).normalized()
		EnemyState.FOLLOW:
			follow()
			direction = (Agent.get_next_path_position() - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
func _on_visual_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Player=body
		PlayerSeen=true
		PlayerHeard=false
func _on_sound_detect_area_entered(area: Area2D):
	if area == Player.get_node("Sound"):
		if !PlayerSeen:
			Ray.target_position=Player.global_position
			PlayerHeard=true
	







#
#
#
#
#
#@onready var soun: CollisionShape2D=$SoundDetect/sound
#@onready var sontim: Timer=$SoundDetect/sontim
#@onready var healthbar:Label=$Health
#@onready var Player:CharacterBody2D= get_parent().get_node("Player")
#var rot :int
#var heard:bool=false
#var stillcansee:bool=false
#var isFollowing=false
#var lastSeenPos:Vector2
#var lastheard:Vector2
#var tims:bool=false
#var dist
#var explicitPositions:Array
#var ExplicitPosition:Vector2
#var startpos:Vector2
#
	#
		#Agent.target_position=explicitPositions[0]
		#if not Agent.is_navigation_finished():
			#direction = (Agent.get_next_path_position() - global_position).normalized()
			#velocity = direction * SPEED
			#move_and_slide()	
		#else:
			#Ray.global_rotation_degrees=0
	#if tims==true:
		#soun.disabled=true
	#if heard:
		#followvoice()
		#direction = (Agent.get_next_path_position() - global_position).normalized()
		#velocity = direction * SPEED
	#elif !heard:
		#velocity = Vector2.ZERO
	#if isFollowing and Player.isSeen:
		#Ray.target_position=Player.global_position-global_position
		#heard=false
		#if stillcansee:
			#FollowPlayer()
		#if Ray.is_colliding() and Ray.get_collider() != Player || dist >700:
			#stillcansee = false
			#GoToLastSeen()
		#if not Agent.is_navigation_finished():
			#direction = (Agent.get_next_path_position() - global_position).normalized()
			#velocity = direction * SPEED
		#else:
			#velocity = Vector2.ZERO
			#lookArround()
	#move_and_slide()
#func _on_sound_detect_area_entered(area: Area2D):
	#if !stillcansee:
		#if area.is_in_group("splayer"):
			#Agent.target_position=Player.global_position
			#dist=Agent.distance_to_target()
			#print(dist)
			#if dist <700:
				#sontim.start()
				#tims=true
				#lastheard=area.global_position
				#look_at(area.global_position)
			#if dist <500:
				#heard=true
#func followvoice():
	#Agent.target_position=lastheard	
#func FollowPlayer():
		#Agent.target_position = Player.global_position
		#dist=Agent.distance_to_target()
		#lastSeenPos=Player.global_position
#func GoToLastSeen():
	#Agent.target_position = lastSeenPos
#func lookArround():
	#if rot==360:
		#Agent.target_position=startpos
		#rot=0
		#Ray.enabled=false
		#direction = (Agent.get_next_path_position() - global_position).normalized()
		#velocity = direction * SPEED
		#move_and_slide()
	#else:
		#VisDetect.rotation += deg_to_rad(45) * get_process_delta_time()
		#rot=rot+rotation_degrees-(rotation_degrees-1)
		#print(rot)
	#
#func _on_sontim_timeout() -> void:
	#tims=false
	#global_rotation_degrees=0
	#soun.disabled=false
