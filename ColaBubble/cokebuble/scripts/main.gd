extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var death_zone: Area2D = $DeathZone


var score: int = 0  # 初始分数为 0
var achievement: int = 0;

func _ready():
	update_score_label()  # 确保游戏开始时 UI 显示初始分数

func update_score_label():
	canvas_layer.get_node("Control/PlayerInfoBox/Label").text = str(score)
	
	
	
func update_achievement_label():
	achievement = score * 25
	canvas_layer.get_node("Control/PlayerInfoBox/Label2").text = str(achievement)
