extends PointLight2D
@onready var enem:CharacterBody2D=get_parent().get_node("Enemy")
@onready var area:Area2D=$Area2D
func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		print("Player aya")
		enabled=false
		enem.lastSeenPos=global_position
		enem.soun.disabled
		enem.ExplicitPosition=global_position
		enem.explicitPositions.push_back(global_position)
	if body.is_in_group("enemy"):
		enabled=true
		
