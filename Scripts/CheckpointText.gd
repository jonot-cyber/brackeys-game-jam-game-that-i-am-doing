extends Label

func _ready():
	
	print(get("rect_position"))
	
func _on_checkpoint():
	print('checkpoint')
	visible = true
	var position_holder = rect_position
	$TextFade.start()
	

func _on_TextFade_timeout():
	visible = false
