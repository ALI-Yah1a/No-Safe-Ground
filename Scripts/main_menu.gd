extends Control











func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass


func _on_expand_button_pressed() -> void:
	$AnimationPlayer.play("Expand animation")
