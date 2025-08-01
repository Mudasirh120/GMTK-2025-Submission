extends PointLight2D
@onready var enem:CharacterBody2D=get_parent().get_node("Enemy")
func _physics_process(delta: float) -> void:
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
