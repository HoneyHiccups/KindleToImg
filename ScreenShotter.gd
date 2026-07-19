class_name main
extends Node
@export var testfire:bool = true
var testimg:Image = null
var cmdarg:PackedStringArray 
var path:String;
var screenshotName:String = "test"
var screenshotNumber:int = 0000;
var MaxPageTurns :int = 0;
var open:bool = false;


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
	#path = "/home/honey/Desktop/book/"

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
	#ready_toTurn = false;
	if(side == -1):
		#in this case we are running a test
		pass
	else:
		screenshotNumber = screenshotNumber+1;
	testfire = false;
	testimg = DisplayServer.screen_get_image(DisplayServer.get_primary_screen())
	var final:Image
	if(side == 1):
		final = testimg.get_region(Rect2i(p1_rect.x,p1_rect.y,p1_rect.w,p1_rect.z))
		#testimg = DisplayServer.screen_get_image_rect(Rect2i(p1_rect.x,p1_rect.y,p1_rect.w,p1_rect.z));
	if(side == 2):
		final = testimg.get_region(Rect2i(p2_rect.x,p2_rect.y,p2_rect.w,p2_rect.z))
		#testimg = DisplayServer.screen_get_image_rect(Rect2i(p2_rect.x,p2_rect.y,p2_rect.w,p2_rect.z));
	if(side == -1):
		final = DisplayServer.screen_get_image(DisplayServer.get_primary_screen())
	if(final == null):
		printerr("test img is null ")
	#else:
		#print("saving %i", screenshotNumber)
	var project_root = OS.get_executable_path().get_base_dir()
	final.convert(Image.FORMAT_L8)
	var footer:String =  "%06d" % screenshotNumber
	#var erro1 = final.save_jpg(path+screenshotName+footer+".jpg",.6)
	var erro = final.save_png(path+screenshotName+footer+".png")
	if (erro != OK):
		printerr(erro)
		return false;
	return true;




var primed:bool = false;



func _physics_process(delta: float) -> void:
	runtime = runtime+delta
	set_vauls()


func _process(delta: float) -> void:
	if(Input.get_action_raw_strength("Page1RectTopFetch") == 1):
		page_1_top_pushvals();
	if(Input.get_action_raw_strength("Page1RectbotFetch")== 1):
		page_1_bot_pushvals();
	if(Input.get_action_raw_strength("Page2RectTopFetch")==1):
		page_2_top_pushvals();
	if(Input.get_action_raw_strength("Page2RectBotFetch")==1):
		page_2_bot_pushvals();
	if(Input.get_action_raw_strength("StartStop")==1):
		open = true;
		
@onready var TurnEditBox: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer/HBoxContainer/LineEdit"
@onready var p_1t_le_x: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer2/p1t_le_x"
@onready var p_1t_le_y: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer2/p1t_le_y"
@onready var p_1b_le_x: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer3/p1b_le_x"
@onready var p_1b_le_y: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer3/p1b_le_y"
@onready var p_2t_le_x: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer4/p2t_le_x"
@onready var p_2t_le_y: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer4/p2t_le_y"
@onready var p_2b_le_x: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer5/p2b_le_x"
@onready var p_2b_le_y: LineEdit = $"../CenterContainer/VBoxContainer/HBoxContainer5/p2b_le_y"


var p1_rect:Vector4 = Vector4(0,0,0,0)
var p2_rect:Vector4 = Vector4(0,0,0,0)

func set_vauls()->void:
	var turnseditboxtext=TurnEditBox.text;
	MaxPageTurns = turnseditboxtext.to_int()
	p1_rect.x = p_1t_le_x.text.to_int()
	p1_rect.y = p_1t_le_y.text.to_int()
	p1_rect.w = p_1b_le_x.text.to_int()
	p1_rect.z = p_1b_le_y.text.to_int()
	
	p2_rect.x = p_2t_le_x.text.to_int()
	p2_rect.y = p_2t_le_y.text.to_int()
	p2_rect.w = p_2b_le_x.text.to_int()
	p2_rect.z = p_2b_le_y.text.to_int()
	pass

var runtime = 0;
var ready_toTurn = true;
var readytoscreeshot:bool = false;
var timetoscreenshota:float = 0;


@onready var timer: Timer = $"../Timer"

func _turnpage()->void:
	if(ready_toTurn == false):
		return;
	ready_toTurn = false;
	timer.start(0);
	pass

func page_1_top_pushvals() -> void:
	#p_1t_le_x.text 
	#p_1t_le_y.text 
	pass
func page_1_bot_pushvals() -> void:
	pass

func page_2_top_pushvals() -> void:
	pass

func page_2_bot_pushvals() -> void:
	pass


func _on_timer_timeout() -> void:
	screenShot(1)
	screenShot(2)
	ready_toTurn = true;
	
