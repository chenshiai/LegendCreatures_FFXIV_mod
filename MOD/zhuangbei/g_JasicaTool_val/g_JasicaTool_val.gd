extends Node
var jaToolVal = JaToolVal.new()
func _ready():
    pass
func _init():
    print("g_JasicaTool_val:全局变量工具类:加载完成")
    sys.main.connect("onBattleStart",self,"run")
    pass
func _connect():
    pass

func run():
    var zdl = {"11":0,"12":0,"21":0,"22":0}
    for cha in sys.main.btChas:
        if cha.team == 1:
            zdl["11"] += 

func get_zdl(cha,type):
    var zdl = 0
    if type:
        zdl += cha.hp
        zdl += cha.hp
    return zdl

class JaToolVal:
    var obj = []
    func _init():
        pass
    func set(key,val):
        if get(key) == null:
            obj.append({key:val})
        else:
            for arr in obj:
                if arr.has(key):
                    arr[key] = val
    func get(key):
        for arr in obj:
            if arr.has(key):
                return arr[key]
        return null