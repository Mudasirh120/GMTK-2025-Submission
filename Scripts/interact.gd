extends RayCast2D
@onready var player:CharacterBody2D=get_parent().get_parent().get_node("Player")
@onready var ray:RayCast2D=get_parent().get_node("interactable")
func _physics_process(delta: float):
	if Input.is_action_just_released("interact"):
		ray.target_position=player.global_position+Vector2(0,100)
		print(ray.target_position)
	pass
func attackdir():
	if player.direction.y>0:
		ray.rotation=0
	elif player.direction.y<0:
		ray.rotation=180
	elif player.direction.x<0:
		ray.rotation=-90
	elif player.direction.x>0:
		ray.rotation=90
