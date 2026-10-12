extends Area2D
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_group("UI", "add_coin")
		collect()
func collect():
	$CollisionShape2D.set_deferred("disabled", true)
	animated_sprite_2d.play("collected")
	pickup_sound.play()
	await animated_sprite_2d.animation_finished
	hide()
	if pickup_sound.playing:
		await pickup_sound.finished
	queue_free()
