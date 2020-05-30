var handle = sys.get_node("../Control")
var path = null

func _init():
  print("最终幻想14：—————— mod完整性检测中 ——————")
  call_deferred("testInit")
  pass


func _ready():
  pass
  
  
func testInit():
  if globalData.infoDs.has("g_FFXIVBuffList"):
    var BuffList = globalData.infoDs["g_FFXIVBuffList"]
    if BuffList != null:
      print("最终幻想14：—————— BUFF列表读取完成 ——————")

    path = chaData.infoDs["cFFXIV_zTatalu"].dir
    if path != null:
      print("最终幻想14：—————— 塔塔露读取完毕 ——————")
  else:
    var label = Label.new()
    label.text = "最终幻想14：BUFF列表读取失败！请在创意工坊内重新订阅"
    print(label.text)
    handle.add_child(label)


func loadImg(path, imgPath):
  var im = Image.new()
  im.load("%s/%s" % [path, imgPath])
  var imt = ImageTexture.new()
  imt.create_from_image(im)
  return imt


func backGroundChange(name):
  sys.main.get_node("scene/bg/bg").set_texture(loadImg(path, "g_FFXIVBG/" + name +".png"))


func createEffect(effectName:String, position:Vector2, deviation:Vector2, frame = 15, scale = 1, repeat = false): 
  var eff = sys.newEff("animEff", position)
  var direc = path + "/effects/" + effectName
  eff.setImgs(direc, frame, repeat)
  eff.normalSpr.position = deviation
  eff.scale *= scale
  return eff


func createTimeAxis(skillAxis):
  var timeAxis = {}
  for sk in skillAxis:
    for timeA in skillAxis[sk]:
      timeAxis[timeA] = sk
  return timeAxis
  

# 数据处理类
class Calculation:
  static func sort_MaxMgiAtk(a, b):
    if a.att.mgiAtk > b.att.mgiAtk:
      return true
    return false

  static func sort_MaxAtk(a, b):
    if a.att.atk > b.att.atk:
      return true
    return false
  
  static func sort_MinHp(a, b):
    if (a.att.hp / a.att.maxHp) < (b.att.hp / b.att.maxHp):
      return true
    return false

  static func getEnemyPower(team):
    var att = {
      "maxHp": 0,
      "atk": 0,
      "mgiAtk": 0,
      "def": 0,
      "mgiDef": 0,
      "lv": 0,
      "num": 0
    }

    for i in sys.main.btChas:
      if i.team != team:
        att["maxHp"] += i.att.maxHp
        att["atk"] += i.att.atk
        att["mgiAtk"] += i.att.mgiAtk
        att["def"] += i.att.def
        att["mgiDef"] += i.att.mgiDef
        att["lv"] += i.lv
        att["num"] += 1

    return att