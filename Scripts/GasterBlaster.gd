extends Node2D

var beam_up_sfx = preload("res://Sounds/mus_sfx_segapower.wav")
var beamsfx = preload("res://Sounds/mus_sfx_rainbowbeam_1.wav")
var beamsfx_a = preload("res://Sounds/mus_sfx_a_gigatalk.wav")

var ideal_pos: Vector2	# Ideal Position
var ideal_rot: float	# Ideal Rotation
var pause: float = 0.3	# Blaster Pause
var end: float = 8		# Blaster End

var spd: float	 # Leaving Speed
var bt: float	 # Blaster Timer
var bs: float	 # Beam Scale
var bw: float	 # Beam Wave
var con: int = 1 # Continuity

func _ready():
	AudioManager.play(beam_up_sfx, 1.2, -4)

func _process(delta):
	match con:
		1: #Go to ideal position
			position += (Vector2((ideal_pos.x - position.x), (ideal_pos.y - position.y)) / 3)
			rotation_degrees += snappedf((ideal_rot - rotation_degrees) / 2.7, 0.1)
			if (abs((position.x - ideal_pos.x)) < 2 && abs((position.y - ideal_pos.y)) < 2):
				$TimerIdle.wait_time = pause
				$TimerIdle.start()
				con = 2
		2: #Wait Idle Timer
			position = ideal_pos
			rotation_degrees = ideal_rot
		3: #Blast
			if ($GasterBlaster.animation == "beam_up" && $GasterBlaster.frame == 3):
				AudioManager.play(beamsfx, 1.2, -4)
				AudioManager.play(beamsfx_a, 1.2, -8)
				$GasterBlaster/Beam.visible = true
				con = 4
		4: #Post-Blast
			bt += 1
			$GasterBlaster.play("blast")
			$GasterBlaster/Beam.scale.x = bs + bw
			
			position -= Vector2(0, 1).rotated(rotation) * spd
			
			if bt < 5:
				spd += 1
#				bs += ((scale.x * 0.9)/(scale.x * 2.5))
				bs += ((scale.x)/scale.x*0.38)
			else:
				spd += 4
				bw = ((sin((bt / 1.5)) * bs) / 4)
			if (bt > 50 && $VSN.is_on_screen() == false): spd = 0
			if (bt > (5 + end)):
				bs *= 0.8
				$GasterBlaster/Beam.modulate.a -= 0.1
			if ($GasterBlaster/Beam.modulate.a <= 0 && $VSN.is_on_screen() == false):
				queue_free()

func _on_timer_idle_timeout():
	$GasterBlaster.play("beam_up")
	con = 3
