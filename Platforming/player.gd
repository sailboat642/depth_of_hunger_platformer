extends CharacterBody2D

# Constants for a "snappy" platformer feel
@export var speed = 250.0
@export var acceleration = 1200.0
@export var friction = 1000.0
@export var jump_velocity = -450.0

# Get the gravity from project settings to keep it consistent
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D
@onready var anim_player = $AnimationPlayer

func _physics_process(delta):
	apply_gravity(delta)
	handle_movement(delta)
	update_animations()
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement(delta):
	# Get input direction: -1 (left), 1 (right), or 0
	var direction = Input.get_axis("move_left", "move_right")

	# Flip logic: Keep the last direction
	if direction > 0:
		sprite.flip_h = false # Facing Right (Default)
	elif direction < 0:
		sprite.flip_h = true  # Facing Left

	# Smooth Acceleration and Friction
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# Jump Logic
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		jump()
		
func jump():
	velocity.y = jump_velocity
	anim_player.play("jump")
	AudioManager.play_sfx("jump_sound")

func update_animations():
	if not is_on_floor():
		anim_player.play("fall")
	elif velocity.x != 0:
		anim_player.play("walk")
	else:
		anim_player.play("idle")
