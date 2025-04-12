extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		animated_sprite_2d.play("out")
		await animated_sprite_2d.animation_finished
		game_over()

func game_over():
	get_tree().change_scene_to_file("res://scene/game_over.tscn")
