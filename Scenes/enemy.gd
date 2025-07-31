extends CharacterBody2D
const SPEED:int=100
var Health:int= 100
@onready var healthbar:Label=$Health
func gotHit():
	Health-=1
	healthbar.text=str(Health)

































@onready var Agent:NavigationAgent2D=$Follow
var Player:CharacterBody2D
var isFollowing=false
func _on_visual_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		isFollowing=true
		body.isSeen = true
		Player=body
func _physics_process(delta: float) -> void:
	if isFollowing and Player.isSeen:
		Agent.target_position = Player.global_position
		var direction = (Agent.get_next_path_position() - global_position).normalized()
		velocity = direction * SPEED
	else:
		velocity = Vector2()
	move_and_slide()


func _on_sound_detect_area_entered(area: Area2D):
	if area.is_in_group("splayer"):
		look_at(area.global_position)
