extends Node

var sfx: Array

func play(snd,pitch:float,vol:float):
	var p = AudioStreamPlayer.new()
	p.stream = snd
	if sfx.has(p.stream):
		repeat_sound(p.stream)
		return
	p.pitch_scale = pitch
	p.volume_db = vol
	add_child(p)
	p.play()
	p.finished.connect(_on_stream_finished.bind(p))
	sfx.append(p.stream)

func repeat_sound(sound):
	for node in get_children():
		if node.stream == sound:
			node.play()
			break

func _on_stream_finished(stream):
	sfx.erase(stream.stream)
	stream.queue_free()
