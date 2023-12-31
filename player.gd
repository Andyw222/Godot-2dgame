extends Area2D
signal hit
@export var speed = 400
var screen_size
var sprite_mode = ""
var indestructible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"): 
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk%s" % sprite_mode
		$AnimatedSprite2D.flip_v = false
		
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up%s" % sprite_mode
		$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.animation = "walk%s" % sprite_mode

func _on_body_entered(body):
	if ! indestructible:
		hit.emit()
		sprite_mode = "_hit"
		indestructible = true
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	
func nolives():
	hide()
	
	$CollisionShape2D.set_deferred("disabled", true)
	
func update_sprite_mode(new_mode):
	sprite_mode = new_mode
	
func update_indestructible(new_mode):
	indestructible = new_mode
