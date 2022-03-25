extends Spatial

onready var StatsText = get_node("../Control/CanvasLayer/RichTextLabel")

func _init():
	VisualServer.set_debug_generate_wireframes(true)

func _input(event):
			
	if event is InputEventKey and Input.is_key_pressed(KEY_P):
		var vp = get_viewport()
		vp.debug_draw = (vp.debug_draw + 1 ) % 4
		
func _ready():
	for child in get_children():
		var face := child as FaceWithHiddenMargin
		face.generate_mesh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_object_local(Vector3(0, 1, 0), delta/19)
	rotate_object_local(Vector3(1, 0, 0), delta/23)
	rotate_object_local(Vector3(0, 0, 1), delta/27)
	
func _on_Button_pressed():
	set_process(not is_processing())
	
	if is_processing():
		StatsText.text = str('Rotation set to ON')
	else:
		StatsText.text = str('Rotation set to OFF')
