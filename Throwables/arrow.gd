extends CharacterBody2D
var targetlocation:Vector2
const SPEED =1
func _ready() -> void:
		look_at(get_global_mouse_position())
func _physics_process(delta: float) -> void:
	if global_position == targetlocation:
		print('Pohanch gya')
	velocity=targetlocation*SPEED
	move_and_slide()
