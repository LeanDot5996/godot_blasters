extends Node2D

func create_blaster(x, y, angle, end=8, pos=Vector2.ZERO, scale=Vector2.ONE):
	var gb = load("res://Objects/blaster.tscn")
	var gbc = gb.instantiate()
	gbc.set("ideal_pos", Vector2(x,y))
	gbc.set("ideal_rot", angle)
	gbc.set("end", end)
	gbc.scale = scale
	gbc.position = pos
	add_child(gbc)

func _input(event):
	if (Input.is_action_pressed("z") == true):
		create_blaster(randf_range(0, 640), randf_range(0, 480), randf_range(0, 360), 1, Vector2.ZERO, Vector2(0.5,1))
	elif (Input.is_action_pressed("1")):
		create_blaster(250, 150, 0)
		create_blaster(150, 250, -90)
		create_blaster(500, 350, 90, 8, Vector2(640,480))
		create_blaster(400, 450, -180, 8, Vector2(640,480))
	elif (Input.is_action_pressed("2")):
		create_blaster(150, 150, -45)
		create_blaster(500, 150, 45, 8, Vector2(640,0))
	elif (Input.is_action_pressed("3")):
		create_blaster(150, 300, -90, 17, Vector2(0,240),Vector2(2,2))
		create_blaster(500, 300, 90, 17, Vector2(640,240),Vector2(2,2))

func _process(delta):
	var fps: float = Engine.get_frames_per_second()
	$FPSLabel.text = "FPS: " + str(fps) + "\n" + "Sounds: " + str(AudioManager.get_child_count())
