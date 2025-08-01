extends PointLight2D
@onready var enem:CharacterBody2D=get_parent().get_node("Enemy")
@onready var torch:PointLight2D=get_parent().get_node("Torch")
@onready var area:Area2D=$Area2D
func _physics_process(delta: float):
	if torch.disabled:
		enem.lastSeenPos=area.global_position
		enem.soun.disabled

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		torch.disabled=true
	if body.is_in_group("enemy"):
		torch.disabled=false
	pass # Replace with function body.
