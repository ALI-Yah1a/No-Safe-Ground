extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buttonrdb_pressed() -> void:
	$Panel.show()
	$Panel2.show()
	$Panel3.show()
	$AnimationPlayer.play("credits animation")


func _on_buttonrdb_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
