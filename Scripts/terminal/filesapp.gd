extends Control
#Preloading Templates
const FILESTEMPLATE = preload("res://Scences/terminal/filesapp/filestemplate.tscn")
const FOLDERTEMPLATE = preload("res://Scences/terminal/filesapp/foldertemplate.tscn")
#Getting File/Folder Box Nodes
@onready var FileBox: VBoxContainer = %FileBox
@onready var FolderBox: VBoxContainer = %FolderBox

var FileTypes = {
	1: "Text",
	2: "Image",
	3: "Application",
	}

func _ready() -> void:
	for I in range(1,4):
		#Getting File Instance
		var Instance = FILESTEMPLATE.instantiate()
		#Getting File Info As Vars
		var FileName = Instance.get_child(0).get_child(0).get_child(0)
		var FileDate = Instance.get_child(0).get_child(0).get_child(1)
		var Filetype = Instance.get_child(0).get_child(0).get_child(2)
		#Setting File Info
		FileName.text = str(I)
		FileDate.text = str(I)
		Filetype.text = FileTypes[I]
		#Adding As child of FileBox
		FileBox.add_child(Instance)
