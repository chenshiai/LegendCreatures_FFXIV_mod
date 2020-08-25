var id = ""         #此MOD创意工坊ID，可选，暂不使用
var name = "g_eqaUtils" #此文件名称
var test = false    #是否开启测试，推荐格式，非必要
var data = []       #想要支持硬盘保存的数据，也可以改成字典或其他类型
var base = null     #基础工具变量名
var handle = sys.get_node("../Control")
var path = null
var switch = null
var ABuff = null
var show  #定义特效

func _ready():
    pass

func _init():
    print("FKG Mod Loading...")
    call_deferred("duwuFKInit")
    pass

func duwuFKInit():
    if globalData.infoDs.has("g_base"):
      base = globalData.infoDs["g_base"]
      path = chaData.infoDs["cex___basedChara"].dir
      ABuff = globalData.infoDs["g_EBuffList"]
      if path != null:
        print("FKG Mod Loaded.")
    else:
      var label = Label.new()
      label.text = "File is not complete."
      print(label.text)
      handle.add_child(label)
    if base != null:
    #在基础工具内注册的数据，建议使用name注册，以提高与其他mod的兼容性
      base.g_sys[name] = data
    #连接基础工具信号，建议使用以下三段连接方式，否则可能导致存档失效
      base.connect("onNewGame",self,"testNewGame")
      base.connect("onNewGame",self,"testGameCtrl")
      base.connect("onLoadGame",self,"testGameCtrl")
func testNewGame():
    #这里是新开始游戏的初始化操作，可以给全局变量赋值、增加装备角色等
    pass
func testGameCtrl():
    pass

#装备升级
func itemUpgrade(item):
	var masCha = item.masCha
	if masCha.isSumm || item.get("upgraded") == null || item.upgraded:return
	var n = 0
	for i in masCha.items:
		if  i.id == item.id && not i.upgraded:
			n += 1
	if n == 3:
		item.upgraded = true
		item.upgrade()
		var index = masCha.items.size()-1
		while(index>=0):
			var i = masCha.items[index]
			if i.id == item.id && not i.upgraded:
				masCha.delItem(i)
				sys.main.player.delItem(i)
			index -= 1