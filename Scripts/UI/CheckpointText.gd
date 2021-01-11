extends Label

export var duration = 1

onready var tween    : Tween = get_node("Tween")
onready var textfade : Timer = get_node("TextFade")

const TRANS = Tween.TRANS_QUAD
const EASE  = Tween.EASE_IN

func _on_checkpoint():
	visible = true
	rect_position = Vector2(-1532,-896)
	
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(rect_position.x,-2000), duration, TRANS, EASE)
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(rect_position.x,-2000), duration, TRANS, EASE)
	tween.start()
	
	textfade.start()
	
func _on_TextFade_timeout():
	visible = false
