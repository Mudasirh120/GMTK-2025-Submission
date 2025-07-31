extends Node2D
class_name Human
var Health:int=100
const SPEED:int=100
func Die():
	queue_free()
func gotHit():
	Health-=1
