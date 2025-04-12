extends Node2D

@export var speed: float = 250  # 泡泡的飞行速度
@export var damage: int = 10   # 泡泡的伤害值
var direction: Vector2         # 泡泡的飞行方向

func _ready():
	# 自动销毁泡泡，防止占用内存
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _process(delta: float) -> void:
	# 按方向移动泡泡
	position += direction * speed * delta

func _on_Bubble_body_entered(body):
	# 检测到与敌人碰撞
	if body.is_in_group("enemies"):  # 确保敌人节点属于 "enemies" 组
		body.take_damage(damage)    # 对敌人造成伤害
		queue_free()                # 销毁泡泡
