extends Control



func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_animation_button_pressed() -> void:
	$AnimationPlayer.play("Levels'animation")


func _on_return_to_main_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_back_1_button_pressed() -> void:
	$Popups/Level1Popup.hide()
	$ColorRect2.hide()


func _on_level_1_button_pressed() -> void:
	$Popups/Level1Popup.show()
	$ColorRect2.show()
	$AnimationPlayer.play("Level1popup")


func _on_level_2_button_pressed() -> void:
	$Popups/Level2Popup.show()
	$ColorRect2.show()
	$AnimationPlayer.play("level2popup")


func _on_back_2_button_pressed() -> void:
	$Popups/Level2Popup.hide()
	$ColorRect2.hide()


func _on_level_3_button_pressed() -> void:
	$Popups/Level3Popup.show()
	$ColorRect2.show()
	$AnimationPlayer.play("level3popup")
	
	


func _on_back_3_button_pressed() -> void:
	$Popups/Level3Popup.hide()
	$ColorRect2.hide()


func _on_level_4_button_pressed() -> void:
	$Popups/Level4Popup.show()
	$ColorRect2.show()
	$AnimationPlayer.play("level4popup")
	


func _on_back_4_button_pressed() -> void:
	$Popups/Level4Popup.hide()
	$ColorRect2.hide()


func _on_level_5_button_pressed() -> void:
	$Popups/Level5Popup.show()
	$ColorRect2.show()
	$AnimationPlayer.play("level5popup")
	


func _on_back_5_button_pressed() -> void:
	$Popups/Level5Popup.hide()
	$ColorRect2.hide()


func _on_enter_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_enter_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_enter_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")


func _on_enter_4_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")


func _on_enter_5_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
