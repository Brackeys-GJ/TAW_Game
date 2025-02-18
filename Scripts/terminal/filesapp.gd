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
	
var StartingFiles = {
	#FORMAT: Key: ["Name", "Date", Filetype],
	1: ["📁  Files","02/18/2025",3],
	2: ["📄  Work Notes","12/18/2025",1],
	3: ["📄  Passwords","03/18/2025",1],
	}

var StartingFolders = {
	#FORMAT: Key: "Name",
	1: "Desktop",
	2: "Downloads",
	3: "Documents",
	4: "Gallery"
	}

func _ready() -> void:
	for I in range(1,4):
		make_file(StartingFiles[I][0], StartingFiles[I][1], StartingFiles[I][2])
	for I in range(1,5):
		make_folder(StartingFolders[I])

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

func make_folder(FolderName: String):
	#Getting Folder Instance
	var Instance = FOLDERTEMPLATE.instantiate()
	#Getting Folder Info As Vars
	var FolderNameText = Instance.get_child(0)
	#Setting Folder Info
	FolderNameText.text = "📁  " + FolderName
	#Adding As child of FolderBox
	FolderBox.add_child(Instance)
