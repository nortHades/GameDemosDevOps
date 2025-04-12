extends CharacterBody2D
@export var ghost_node : PackedScene
@export var bubble_scene: PackedScene
@onready var ghost_timer = $GhostTimer
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var animation = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var counter = 0;

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var facing_direction = Vector2.RIGHT  # Default to facing right


func _ready() -> void:
	animation.play("idle")

func _physics_process(delta: float) -> void:
	#var right = Input.is_action_pressed("ui_right")
	#var left = Input.is_action_pressed("ui_left")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimationPlayer.play("jump")

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		sprite_2d.flip_h = false
		animation.play("move")
		facing_direction = Vector2.RIGHT
		velocity.x = direction * SPEED
	elif direction < 0:
		sprite_2d.flip_h = true
		animation.play("move")
		facing_direction = Vector2.LEFT
		velocity.x = direction * SPEED
	else:
		sprite_2d.flip_h = false
		animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#if velocity != Vector2.ZERO:
		#velocity = velocity.normalized() * SPEED

	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		shoot_bubble()

func add_ghost():
	var ghost = ghost_node.instantiate()
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	if right:
		ghost.flip_h = false
	elif left:
		ghost.flip_h = true
		
	ghost.set_property(position, $Sprite2D.scale)
	get_tree().current_scene.add_child(ghost)
	
	


func _on_ghost_timer_timeout() -> void:
	add_ghost()

func dash():
	ghost_timer.start()
	particles.emitting = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + velocity.normalized() * SPEED * 0.5 * 1.08, 0.3)
	await tween.finished
	ghost_timer.stop()
	
	particles.emitting = false

func _input(event):
	if event.is_action_pressed("dash") and velocity.y <= 0:
		dash()

func shoot_bubble():
	# 创建泡泡实例
	var bubble = bubble_scene.instantiate()
	# 设置泡泡的初始位置为角色的位置
	bubble.position = position
	# 根据角色朝向设置泡泡的飞行方向
	bubble.direction = facing_direction
	get_tree().current_scene.add_child(bubble)
