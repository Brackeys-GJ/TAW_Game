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
	#FORMAT: Key: ["Name", "Date", Filetype, Folder(Not needed)],
	1: ["📁  Files","01/03/2059",3,1],
	2: ["📄  Work Notes","11/18/2062",1,3],
	3: ["📄  Passwords","03/18/2059",1,3],
	4: ["💿  Command Prompt","01/03/2059",1],
	}

var StartingFilesAmount = len(StartingFiles)

var StartingFolders = {
	#FORMAT: Key: "Name",
	1: "Desktop",
	2: "Downloads",
	3: "Documents",
	4: "Gallery"
	}

func _ready() -> void:
	for I in range(1,StartingFilesAmount + 1):
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
