extends CharacterBody2D
const SPEED:int=100
var Health:int= 100
@onready var healthbar:Label=$Health
func gotHit():
	Health-=1
	healthbar.text=str(Health)
