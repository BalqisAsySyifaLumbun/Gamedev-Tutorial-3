extends CharacterBody2D

@export var walk_speed = 200
@export var dash_speed = 400
@export var gravity = 200.0
@export var jump_speed = -250
@onready var sprite_2d = $Sprite2D
@export var max_jumps: int = 2 
@export var max_dash: int = 3 
var jumps_left: int = max_jumps
var dash_left: int = max_dash
var power_dash: int = 1
const tap_interval = 1
var tap_time = 0
var right_press = 0
var left_press = 0
#https://www.youtube.com/watch?v=GpLy_e1s14A

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	velocity.y += delta * gravity
	
	
	if is_on_floor():
		jumps_left = max_jumps
		
	if Input.is_action_just_pressed('ui_up'):
		if jumps_left > 0:
			velocity.y = jump_speed
			jumps_left -= 1
			sprite_2d.animation = "jump"
		
		
	if Input.is_action_pressed("ui_left"):
		sprite_2d.flip_h = true
		if Input.is_action_pressed("ui_up"):
			sprite_2d.animation = "jump" 
			velocity.x = -walk_speed
		elif Input.is_action_just_pressed("ui_left"):
			if Time.get_ticks_msec() / 1000 - (2*tap_time) < tap_interval:
				velocity.x = -dash_speed
		else:
			velocity.x = -walk_speed
		tap_time = Time.get_ticks_msec() / 1000
		sprite_2d.animation = "walk"
		
	elif Input.is_action_pressed("ui_right"):
		right_press += 1
		sprite_2d.flip_h = false
		print("Taptime: ",tap_time)
		print("Much: ",Time.get_ticks_msec() / 1000)
		print("Res: ",Time.get_ticks_msec() / 1000 - tap_time)
		if Input.is_action_just_pressed("ui_right") and right_press >= 1:
				print("Tru mint")
				velocity.x = dash_speed
				print("Dasher")
				
		elif Input.is_action_pressed("ui_up"):
			sprite_2d.animation = "jump"
			velocity.x =  walk_speed
			print("Jumrite")
		else:
			print("Walkrite")
			velocity.x =  walk_speed
		tap_time = Time.get_ticks_msec() / 1000
		sprite_2d.animation = "walk"
	else:
		velocity.x = 0
		sprite_2d.animation = "idle"
		tap_time = 0
		right_press = 0
		left_press = 0

	# "move_and_slide" already takes delta time into account.
	move_and_slide()
