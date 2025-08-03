extends CharacterBody2D
enum EnemyState { PATROL, FOLLOW}
var EnemTask:EnemyState = EnemyState.PATROL
@onready var Agent:NavigationAgent2D=$Follow
var direction:Vector2
const SPEED= 500
@onready var StartNode=$"../PatrolPoint1"
@onready var EndNode=$"../PatrolPoint2"
var StartPoint:Vector2
var EndPoint:Vector2
func _ready() -> void:
	StartPoint=StartNode.global_position
	global_position = StartPoint
	EndPoint=EndNode.global_position
	Agent.target_position = EndPoint
func toggle(one,two,temp):
	temp=one
	one =two
	two=temp
	return [one,two]
var dir:bool=false
func Patrol():
	if Agent.is_navigation_finished():
		if dir:
			Agent.target_position=StartPoint
			dir=!dir
		else:
			Agent.target_position=EndPoint
			dir=!dir
	direction = (Agent.get_next_path_position() - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
func _physics_process(delta: float):
	match EnemTask:
		EnemyState.PATROL:
			Patrol()
		EnemyState.FOLLOW:
			print("")
