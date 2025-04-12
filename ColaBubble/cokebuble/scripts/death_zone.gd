extends Area2D

func _on_body_entered(body: Node):
	if body.name == "player":  # 检测是否是角色
		restart_game()

func restart_game():
	get_tree().change_scene_to_file("res://scene/game_over.tscn")
