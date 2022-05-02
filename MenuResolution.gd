extends MenuButton

var popup

func _ready():
	popup = get_popup()
	popup.add_item("32")
	popup.add_item("64")
	popup.add_item("128")
	popup.add_item("256")

	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	print(popup.get_item_text(ID), " pressed")
