extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 220.0
const JUMP_VELOCITY = -320.0
var is_hurt = false
var max_health = 4
var current_health = 4
var is_appearing = true 
var has_double_jumped = false 
signal health_changed(new_health)

func _ready():
	is_appearing = true
	animated_sprite_2d.play("appear")
	await animated_sprite_2d.animation_finished
	is_appearing = false

func _input(event):
	if is_hurt or is_appearing:
		return
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not has_double_jumped:
			velocity.y = JUMP_VELOCITY
			has_double_jumped = true

func _physics_process(delta):

	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		has_double_jumped = false
	if is_hurt or is_appearing:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		var direction = Input.get_axis("walk_left", "walk_right")
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		update_facing_direction(direction)
		update_animations(direction)

	move_and_slide()

func update_facing_direction(direction: float):
	if direction == 0:
		return 
		
	var is_facing_left = direction < 0
	animated_sprite_2d.flip_h = is_facing_left
	
	if is_facing_left:
		animated_sprite_2d.position.x = 0
	else:
		animated_sprite_2d.position.x = 0

func update_animations(direction: float):
	if not is_on_floor():
		if has_double_jumped:
			animated_sprite_2d.play("double_jump")
		else:
			animated_sprite_2d.play("jump")
	elif direction != 0:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")

func take_damage(amount):
	if is_hurt or is_appearing: 
		return

	current_health -= amount
	current_health = clamp(current_health, 0, max_health)
	health_changed.emit(current_health)
	
	if current_health > 0:
		is_hurt = true
		animated_sprite_2d.play("hit")
		await animated_sprite_2d.animation_finished
		is_hurt = false
	else:
		die()

func die():
	set_physics_process(false)
	animated_sprite_2d.play("die")
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
