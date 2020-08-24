var name = "g_base"
var test = false
var g_sys = {"leader.three":true}
var file = File.new()
var ctrl = null

signal onNewGame    #选人界面时发射信号
signal onLoadGame   #读取完成时发射信号
signal onSaveGame   #退回标题页面时发射信号

func _init():
    ctrl = sys.get_node("../Control")
    if file.file_exists("user://data1/main.save"):
        ctrl.connect("tree_exited",self,"disMenuNewLoad")
    else:
        ctrl.connect("tree_exited",self,"disMenuNew")
func disMenuNew():
    if test: print("Sys:New Game")
    initData()
    sys.main.connect("tree_exited",self,"disGameMain")
    emit_signal("onNewGame")
func disMenuNewLoad():
    if file.file_exists("user://data1/main.save"):
        if test: print("Sys:New Game")
        initData()
        emit_signal("onNewGame")
    else:
        if test: print("Sys:Continue Game")
        loadData()
        emit_signal("onLoadGame")
    sys.main.connect("tree_exited",self,"disGameMain")

func disGameMain():
    if test: print("Sys:Pause Game")
    ctrl = sys.get_node("../Control")
    ctrl.connect("tree_exited",self,"disMenuNewLoad")
    saveData()
    emit_signal("onSaveGame")

func initData():
    g_sys = {"leader.three":true}
    if test: print("Data:Init %s" % name)
func loadData():
    if file.file_exists("user://data1/%s.save" % name):
        file.open("user://data1/%s.save" % name, File.READ)
        if file.get_len() > 0:
            g_sys = parse_json(file.get_line())
            if test: print("Data:Load %s" % name)
        file.close()
func saveData():
    file.open("user://data1/%s.save" % name, File.WRITE)
    file.store_line(to_json(g_sys))
    if test: print("Data:Save %s" % name)
    file.close()
