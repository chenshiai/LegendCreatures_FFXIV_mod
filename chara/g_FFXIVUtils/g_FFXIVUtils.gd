var handle = sys.get_node("../Control")
var path = null

func _ready():
  pass

func _init():
  print("最终幻想14：—————— mod完整性检测中 ——————")
  call_deferred("testInit")
  pass

func testInit():
  if globalData.infoDs.has("g_FFXIVBuffList"):
    var BuffList = globalData.infoDs["g_FFXIVBuffList"]
    if BuffList != null:
      print("最终幻想14：—————— BUFF列表加载完成 ——————")

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
  # 魔法强度排序
  static func sortMgiAtkMax(a,b):
    if a.att.mgiAtk > b.att.mgiAtk :
      return true
    return false

  # 物理攻击排序
  static func sortAtkMax(a,b):
    if a.att.atk > b.att.atk :
      return true
    return false

  static func findOneByMinHp(chas):
    var cha = null
    var m = 10000
    for i in chas:
      if i.att.hp / i.att.maxHp < m :
        cha = i
        m = i.att.hp / i.att.maxHp
    return cha
  
  static func findOneByMaxHp(chas):
    var cha = null
    var m = 0
    for i in chas:
      if i.att.hp / i.att.maxHp > m :
        cha = i
        m = i.att.hp / i.att.maxHp
    return cha