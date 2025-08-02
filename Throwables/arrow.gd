extends CharacterBody2D
@onready var Enemy 
var targetlocation:Vector2
const SPEED =500
var isCollided:bool=false
var checkforCollision=false
@onready var sprite:Sprite2D=$Sprite2D
var dir:Vector2
func assigndir():
	dir=targetlocation.normalized()
func ready():
	call_deferred(assigndir())
func _physics_process(delta: float) -> void:
	dir=targetlocation.normalized()
	if global_position == targetlocation:
		print('Pohanch gya')
	if !isCollided:
		velocity=SPEED*dir
	else:
		velocity=Vector2()
	move_and_slide()
func _on_hit_body_entered(body: Node2D) -> void:
	#if checkforCollision:
	
	
	if body.is_in_group("Player"):
		isCollided=false
		print("wrong collide")
	elif body.is_in_group('enemy'):
		body.gotHit()
		print(Enemy)
		isCollided=true
		print("Banda mara")
		print("iscollided elif")
	else:
		isCollided=true
		print("iscollided else")
		print("dewaar")
func _on_hit_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		checkforCollision=true
