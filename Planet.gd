extends Spatial

onready var StatsText = get_node("../Control/CanvasLayer/RichTextLabel")
onready var Btn = get_node("../Control/CanvasLayer/Button")
onready var MenuRes = get_node("../Control/CanvasLayer/VBoxContainer/MenuButton")

var resolution := 32
var margin := 3
var num_vertices : int = ((resolution * resolution) + (margin * (resolution - 1) * 4)) * 6
var bench : String = ''
var bench_time : float = 0.0
var update_stats = false

var popup

func _init():
	VisualServer.set_debug_generate_wireframes(true)

func save(content):
	# This saves to res:// but is not visible in editor file browser until extension changed.
	var file = File.new()
	file.open("res://test_save.txt", File.WRITE)
	file.store_string(content)
	file.close()

func generate_sphere():
	var startTime = OS.get_ticks_msec()

	for child in get_children():
		var face := child as FaceWithHiddenMargin
		face.generate_mesh(resolution, margin)
		
	var endTime = OS.get_ticks_msec()
	bench_time = (endTime - startTime) / 1000.0

	update_stats = true

func _input(event):
	if event is InputEventKey and Input.is_key_pressed(KEY_P):
		var vp = get_viewport()
		vp.debug_draw = (vp.debug_draw + 1 ) % 4
		
	if event is InputEventKey and Input.is_key_pressed(KEY_U):
		StatsText.visible = not StatsText.visible
		Btn.visible = not Btn.visible
		
func _ready():
	save("I am test content.\nSave me!")
	
	generate_sphere()

	popup = MenuRes.get_popup()
	popup.add_item("32")
	popup.add_item("64")
	popup.add_item("128")
	popup.add_item("256")

	popup.connect("id_pressed", self, "_on_item_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_object_local(Vector3(0, 1, 0), delta/19)
	rotate_object_local(Vector3(1, 0, 0), delta/23)
	#rotate_object_local(Vector3(0, 0, 1), delta/27)
	
func _physics_process(_delta):	
	if update_stats == true:
		bench = "time to render = %.3f" % bench_time
		num_vertices = ((resolution * resolution) + (margin * (resolution - 1) * 4)) * 6
		var indices : float = Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME)
	
		StatsText.text = (
			"FPS: " + str(Performance.get_monitor(Performance.TIME_FPS)) + "\n\n"
			+ "Memory static:  " + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + " MB\n"
			+ "Memory dynamic: " + str(round(Performance.get_monitor(Performance.MEMORY_DYNAMIC)/1024/1024)) + " MB\n"
			+ "Vertex memory:  " + str(round(Performance.get_monitor(Performance.RENDER_VERTEX_MEM_USED)/1024/1024)) + " MB\n"
			+ "Texture memory: " + str(round(Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED)/1024/1024)) + " MB\n\n"
			+ "Resolution:     " + str(resolution) + "\n"
			+ "Indices:        " + str(indices) + "\n"
			+ "Triangles:      " + str(indices / 6)  + "\n"
			+ "Mesh vertices:  " + str(num_vertices) + "\n\n"
			+ bench
			)

		update_stats = false
		
func _on_Button_pressed():
	set_process(not is_processing())
	
	if is_processing():
		StatsText.text = str('Rotation set to ON')
	else:
		StatsText.text = str('Rotation set to OFF')

func menu_resolution_select():
	print("hello from Planet.gd")

func _on_item_pressed(ID):
	resolution = int(popup.get_item_text(ID))
	print(resolution, " pressed (via Planet class)")

	generate_sphere()
