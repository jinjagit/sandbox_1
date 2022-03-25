extends Spatial

onready var StatsText = get_node("../Control/CanvasLayer/RichTextLabel")
onready var Btn = get_node("../Control/CanvasLayer/Button")

var resolution := 64
var margin := 3
var num_vertices : int = ((resolution * resolution) + (margin * (resolution - 1) * 4)) * 6

func _init():
	VisualServer.set_debug_generate_wireframes(true)

func _input(event):
	if event is InputEventKey and Input.is_key_pressed(KEY_P):
		var vp = get_viewport()
		vp.debug_draw = (vp.debug_draw + 1 ) % 4
		
	if event is InputEventKey and Input.is_key_pressed(KEY_U):
		StatsText.visible = not StatsText.visible
		Btn.visible = not Btn.visible
		
func _ready():
	for child in get_children():
		var face := child as FaceWithHiddenMargin
		face.generate_mesh(resolution, margin)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_object_local(Vector3(0, 1, 0), delta/19)
	rotate_object_local(Vector3(1, 0, 0), delta/23)
	rotate_object_local(Vector3(0, 0, 1), delta/27)
	
func _physics_process(_delta):
	var indices : float = Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME)
	
	StatsText.text = (
		"FPS: " + str(Performance.get_monitor(Performance.TIME_FPS)) + "\n\n"
		+ "Memory static:  " + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + " MB\n"
		+ "Memory dynamic: " + str(round(Performance.get_monitor(Performance.MEMORY_DYNAMIC)/1024/1024)) + " MB\n"
		+ "Vertex memory:  " + str(round(Performance.get_monitor(Performance.RENDER_VERTEX_MEM_USED)/1024/1024)) + " MB\n"
		+ "Texture memory: " + str(round(Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED)/1024/1024)) + " MB\n"
		+ "Indices:        " + str(indices) + "\n"
		+ "Triangles:      " + str(indices / 6)  + "\n"
		+ "Mesh vertices:  " + str(num_vertices)
		)
		
	
func _on_Button_pressed():
	set_process(not is_processing())
	
	if is_processing():
		StatsText.text = str('Rotation set to ON')
	else:
		StatsText.text = str('Rotation set to OFF')
