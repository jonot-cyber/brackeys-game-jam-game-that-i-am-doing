extends Label

func _on_checkpoint():
	visible = true
	rect_position = Vector2(-1532,-896)
	$Tween.interpolate_property(self,"rect_position",rect_position,Vector2(rect_position.x,-2000),1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.interpolate_property(self,"rect_position",rect_position,Vector2(rect_position.x,-2000),1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	$TextFade.start()
	
func _on_TextFade_timeout():
	visible = false