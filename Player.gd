extends Area2D

@export var speed = 200
@onready var collistion_rect: CollisionShape2D = $CollisionShape2D

var direction = Vector2.ZERO
var bounding_size_x
var start_bound
var end_bound


# Called when the node enters the scene tree for the first time.
func _ready():
	bounding_size_x = collistion_rect.shape.get_rect().size.x
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position
	start_bound = (camera.position.x - rect.size.x) / 2
	end_bound = (camera.position.x + rect.size.x) / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Input.get_axis("move_left", "move_right")
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
		
	var delta_movement = direction.x * speed * delta
	
	if(position.x + delta_movement < start_bound + bounding_size_x * transform.get_scale().x ||
	   position.x + delta_movement > end_bound - bounding_size_x * transform.get_scale().x):
		return
		
	position.x += delta_movement
