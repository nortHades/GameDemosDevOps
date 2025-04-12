extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var root = get_tree().root.get_node("main")
		root.score += 1;
		root.update_score_label()  # update
		root.update_achievement_label() #update
		animated_sprite_2d.play("collected")
		await animated_sprite_2d.animation_finished
		
		queue_free()
		
