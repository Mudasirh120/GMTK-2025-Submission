extends PointLight2D
@onready var enem:CharacterBody2D=get_parent().get_node("Enemy")
@onready var area:Area2D=$Area2D
func _physics_process(delta: float):
	if !enabled:
		enem.lastSeenPos=global_position
		enem.soun.disabled
		enem.ExplicitPosition=global_position
func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		print("Player aya")
		enabled=false
	if body.is_in_group("enemy"):
		enabled=true
