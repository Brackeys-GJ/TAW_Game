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
		make_file("placeholder", "02/18/2025", I)

func make_file(FileName: String, FileDate: String, Filetype: int):
		#Getting File Instance
		var Instance = FILESTEMPLATE.instantiate()
		#Getting File Info As Vars
		var FileNameLabel = Instance.get_child(0).get_child(0).get_child(0)
		var FileDateLabel = Instance.get_child(0).get_child(0).get_child(1)
		var FiletypeLabel = Instance.get_child(0).get_child(0).get_child(2)
		#Setting File Info
		FileNameLabel.text = FileName
		FileDateLabel.text = FileDate
		FiletypeLabel.text = FileTypes[Filetype]
		#Adding As child of FileBox
		FileBox.add_child(Instance)
