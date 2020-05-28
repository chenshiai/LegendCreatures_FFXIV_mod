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
  im.load("%s/%s" % [path,imgPath])
  var imt = ImageTexture.new()
  imt.create_from_image(im)
  return imt


func backGroundChange():
  sys.main.get_node("scene/bg/bg").set_texture(loadImg(path, "g_FFXIVBG/bg_normal2.png"))

# 创建自定义特效方法
# 入参
# effectName{string} 特效名字
# position{Vector2} 创建位置
# deviation{Vector2} 偏移位置
# frame 播放速率
# scale 缩放比率
# repeat 是否重复播放
# 返回 eff对象
func createEffect(effectName:String, position:Vector2, deviation:Vector2, frame = 15, scale = 1, repeat = false): 
  var eff = sys.newEff("animEff", position)
  var direc = path + "/effects/" + effectName
  eff.setImgs(direc, frame, repeat)
  eff.normalSpr.position = deviation
  eff.scale *= scale
  return eff

# 计算排序类
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


  static func sortChasByMgiAtk(chas):
	  return chas.sort_custom(self, "sort_MaxMgiAtk")


  static func sortChasByAtk(chas):
	  return chas.sort_custom(self, "sort_MaxAtk")


  static func sortChasByMinHp(chas):
    return chas.sort_custom(self, "sort_MinHp")
    

  # static func findOneByMinHp(chas):
  #   var cha = null
  #   var m = 10000
  #   for i in chas:
  #     if i.att.hp / i.att.maxHp < m:
  #       cha = i
  #       m = i.att.hp / i.att.maxHp
  #   return cha