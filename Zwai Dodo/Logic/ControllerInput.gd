extends Node2D

# ControllerInput

export(bool) var disable_this = false

const deadzone = 0.5
var controller_active = false

onready var controllerAimPoint = $ControllerAimPoint


# very clean lol
func _input(event):
	
	if event.is_action("enable_controller") and event.get_action_strength("enable_controller") > deadzone:
		controller_active = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if event.is_action("enable_keyboard"):
		controller_active = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _process(delta):
#	if controller_active and !disable_this:
#		var axis = Vector2(Input.get_joy_axis ( 0,JOY_AXIS_2 ), Input.get_joy_axis ( 0,JOY_AXIS_3 ))
#		if abs(axis.x) < deadzone and abs(axis.y) < deadzone:
#			return
#
#		var gun_pos_on_screen = get_global_transform_with_canvas().get_origin()
#		Input.warp_mouse_position(gun_pos_on_screen + 50*axis)

	if controller_active and !disable_this:
		var axis = Vector2(Input.get_joy_axis ( 0,JOY_AXIS_2 ), Input.get_joy_axis ( 0,JOY_AXIS_3 ))
		if abs(axis.x) < deadzone and abs(axis.y) < deadzone:
			return
		
		controllerAimPoint.position = 150 * axis.normalized()
