extends CharacterBody2D

# Constants for a "snappy" platformer feel
const SPEED = 250.0
const ACCELERATION = 1200.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -450.0

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
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	# Jump Logic
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

func update_animations():
	if not is_on_floor():
		anim_player.play("jump")
	elif velocity.x != 0:
		anim_player.play("walk")
	else:
		anim_player.play("idle")
