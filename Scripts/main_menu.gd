extends Control











func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass


func _on_expand_button_pressed() -> void:
	$AnimationPlayer.play("Expand animation")


func _on_leave_button_pressed() -> void:
	$LeaveFade.show()
	$LeavePopup.show()
	
	$AnimationPlayer.play("QuitPopup")


func _on_yes_button_pressed() -> void:
	get_tree().quit()
	
	



func _on_no_button_pressed() -> void:
	$LeaveFade.hide()
	$LeavePopup.hide()


func _on_fold_button_pressed() -> void:
	$AnimationPlayer.play("FoldAnimation")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels.tscn")
