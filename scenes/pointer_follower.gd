extends CharacterBody2D

var SPEED = 800

var current_child = null

var vp
var y_offset
var y_overlap

var x_offset
var x_overlap
var target_pos
func _physics_process(delta):
	if current_child != null:
		vp = get_viewport()
		
		y_overlap = (vp.get_mouse_position().y+current_child.size.y) - vp.size.y
		y_offset = y_overlap if y_overlap>0.0 else 0.0
		
		x_overlap = (vp.get_mouse_position().x+current_child.size.x) - vp.size.x
		x_offset = x_overlap if x_overlap>0.0 else 0.0
		
		target_pos = vp.get_mouse_position() + Vector2(10.0,-50.0)
		target_pos.x -= x_offset
		target_pos.y -= y_offset
		
		var direction = (target_pos ) - self.position
		velocity = direction * delta * SPEED
		move_and_slide()

func _ready() -> void:
	position = get_viewport().get_mouse_position()
