extends CharacterBody2D
@onready var Enemy 
var targetlocation:Vector2
const SPEED =1
var isCollided:bool=false
var checkforCollision=false
@onready var sprite:Sprite2D=$Sprite2D
func _ready() :
	pass
func _physics_process(delta: float) -> void:
	if global_position == targetlocation:
		print('Pohanch gya')
	if !isCollided:
		velocity=targetlocation*SPEED
	else:
		velocity=Vector2()
	move_and_slide()
func _on_hit_body_entered(body: Node2D) -> void:
	if checkforCollision:
		isCollided=true
		print(Enemy)
		if body.is_in_group('enemy'):
			body.gotHit()
			print("Banda mara")
		else:
			print("dewaar")
func _on_hit_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		checkforCollision=true
