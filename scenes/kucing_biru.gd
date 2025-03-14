extends Area2D

@onready var sprite_2d = $AnimatedSprite2D
@onready var text = $RichTextLabel
@onready var telolet = $AudioStreamPlayer2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.flip_h = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("Masuk")
		sprite_2d.play("run")
		text.visible = true
		telolet.play()


func _on_body_exited(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("Cabut")
		sprite_2d.play("idle")
		text.visible = false
		telolet.stop()
