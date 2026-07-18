
extends Node
@export var testfire:bool = true
var testimg:Image = null
var cmdarg:PackedStringArray 
var path:String;
var screenshotName:String = "test"
var screenshotNumber:int = 0000;
var MaxPageTurns :int = 0;



@onready var status: Label = $"../CenterContainer/VBoxContainer/Status"

func _ready() -> void:
	status.text = "Test"
	cmdarg = OS.get_cmdline_args()
	var temp:String = "Working dir is::"
	print_rich("[color=blue]", temp,cmdarg)
	print_rich("[color=green]testing dir")
	path ="";
	for s in cmdarg:
		path = path+s;
	path = path+ '/';
	if(screenShot(-1) == true):
		print_rich("[color=red] File should be in working dir, look for test.png");
		screenshotName = "page_";
	else:
		printerr("test save failed, fix path, or maybe folder perms")
	status.text = "ready"


func warpclickRight():
	pass

func warpclickLeft():
	pass


func screenShot(side:int)->bool:
	if(side == -1):
		#in this case we are running a test
		pass
	else:
		screenshotNumber = screenshotNumber+1;
	testfire = false;
	testimg = DisplayServer.screen_get_image(DisplayServer.get_primary_screen())
	if(testimg == null):
		printerr("test img is null ")
		return false;
	var project_root = OS.get_executable_path().get_base_dir()
	testimg.convert(Image.FORMAT_L8)
	var footer:String =  "%06d" % screenshotNumber
	var erro = testimg.save_png(path+screenshotName+footer+".png")
	if (erro != OK):
		return false;
	return true;

func _physics_process(delta: float) -> void:
	set_vauls()


@onready var TurnEditBox: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer/HBoxContainer/LineEdit"

func set_vauls()->void:
	var turnseditboxtext=TurnEditBox.text;
	MaxPageTurns = turnseditboxtext.to_int()
	pass
