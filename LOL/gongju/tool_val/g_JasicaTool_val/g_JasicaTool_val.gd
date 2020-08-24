extends Node
var jaToolVal = JaToolVal.new()
func _ready():
    pass
func _init():
    print("g_JasicaTool_val:全局变量工具类:加载完成")
    pass
func _connect():
    pass

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