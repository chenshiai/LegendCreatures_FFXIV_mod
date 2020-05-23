var handle = sys.get_node("../Control")
var bufflist = null
var path = null

func _ready():
  pass

func _init():
  print("最终幻想14：mod完整性检测······")
  call_deferred("testInit")
  pass

func testInit():
  if globalData.infoDs.has("g_FFXIVBuffList"):
    bufflist = globalData.infoDs["g_FFXIVBuffList"]
    path = chaData.infoDs["cFFXIV_zTatalu"].dir
    if path != null:
      print("最终幻想14：BUFF列表读取完成")
  else:
    var label = Label.new()
    label.text = "最终幻想14：BUFF列表读取失败，请在创意工坊内重新订阅"
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
