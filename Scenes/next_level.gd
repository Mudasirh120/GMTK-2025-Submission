extends CharacterBody2D
const BASE_PATH = 'res://Levels/level_'
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var currentFile = get_tree().current_scene.scene_file_path
		print(currentFile)
		var nextLevel = currentFile.to_int()+1
		print(nextLevel)
		var nextLevelFile=BASE_PATH+str(nextLevel)+".tscn"
		#var nextLevelFile=BASE_PATH+"0"+".tscn"
		print(nextLevelFile)
		get_tree().change_scene_to_file(nextLevelFile)
