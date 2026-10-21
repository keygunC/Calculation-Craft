extends Label


# Updates slot label
func change(newType: Matherial.TYPE, newContent) -> void:
	if newContent == null:
		text = ''
		return
	
	match newType:
		Matherial.TYPE.NUMBER:
			text = str(newContent)
		Matherial.TYPE.OPERATOR:
			text = Matherial.OPERATOR_STRING[newContent]
