extends CharacterBody2D

@export var walk_speed = 200
@export var dash_speed = 400
@export var gravity = 100.0
@export var jump_speed = -250
@onready var kucing_biru= get_parent().get_node('KucingBiru')
@onready var sprite_2d = $Sprite2D
@onready var text_2d = $RichTextLabel
@export var max_jumps: int = 2
var jumps_left: int = max_jumps

const tap_interval = 0.3  
var last_left_tap_time = 0.0
var last_right_tap_time = 0.0
var dashing = false  
var dash_timer = 0.2  
var dash_time_left = 0.0

#func _ready():
	#kucing_biru = get_parent().get_node_or_null('KucingBiru')
	#if kucing_biru:
	#	print("Found KucingBiru")
	#else:
	#	print("KucingBiru node not found!")

func _physics_process(delta):
	
	if self.global_position.x > 980 and self.global_position.x < 1400:
		if self.global_position.y > 600:
			sprite_2d.animation = "walk"
			if sprite_2d.animation == "walk":
				print("True mint")
			text_2d.visible = true
	else:
		text_2d.visible = false
	
	velocity.y += gravity * delta  

	if is_on_floor():
		jumps_left = max_jumps

	if Input.is_action_just_pressed('ui_up') and jumps_left > 0:
		velocity.y = jump_speed
		jumps_left -= 1
		sprite_2d.animation = "jump"

	var direction = 0
	if dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			dashing = false 
	else:
		if Input.is_action_just_pressed("ui_left"):
			var now = Time.get_ticks_msec() / 1000.0
			if now - last_left_tap_time < tap_interval:
				dashing = true
				dash_time_left = dash_timer
				velocity.x = -dash_speed
			else:
				velocity.x = -walk_speed
			last_left_tap_time = now
			sprite_2d.flip_h = true
			sprite_2d.animation = "walk"

		elif Input.is_action_just_pressed("ui_right"):
			var now = Time.get_ticks_msec() / 1000.0
			if now - last_right_tap_time < tap_interval:
				dashing = true
				dash_time_left = dash_timer
				velocity.x = dash_speed
			else:
				velocity.x = walk_speed
			last_right_tap_time = now
			sprite_2d.flip_h = false
			sprite_2d.animation = "walk"

		elif Input.is_action_pressed("ui_left"):
			velocity.x = -walk_speed
			sprite_2d.flip_h = true
			sprite_2d.animation = "walk"
		
		elif Input.is_action_pressed("ui_right"):
			velocity.x = walk_speed
			sprite_2d.flip_h = false
			sprite_2d.animation = "walk"


		else:
			velocity.x = 0
			sprite_2d.animation = "idle"
			if self.global_position.x > 980 and self.global_position.x < 1400:
				if self.global_position.y > 600:
					sprite_2d.animation = "walk"

	move_and_slide()
