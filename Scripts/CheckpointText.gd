extends Label

func _on_checkpoint():
	print('checkpoint')
	visible = true
	var position_holder = rect_position
	$Tween.interpolate_property(self,"rect_position",rect_position,Vector2(rect_position.x,-2000),1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.interpolate_property(self,"rect_position",rect_position,Vector2(rect_position.x,-2000),1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	$TextFade.start()
	
func _on_TextFade_timeout():
	visible = false
