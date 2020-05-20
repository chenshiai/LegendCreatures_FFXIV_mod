extends Talent

const TIMEOUT = 240 # 0级的倒计时
func init():
	name = "光之加护"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
  for i in sys.main.btChas:
    if i.team == 1:
      i.addBuff(Bf.new(TIMEOUT - lv * 10))

func get_info():
  return "妈水晶海德林喊你回一趟沙之家，赶紧结束战斗吧！当战斗时间超过%d秒后，己方角色的攻击力提升500%，并获得500点护甲穿透" % [(TIMEOUT - lv * 10)]

class Bf:
	extends Buff

  func _init(lv):
		attInit()
		isNegetive = false
    life = 240
    self.lv = lv
	
	func _upS():
    if life < (240 - lv):
      att.atkL = 5
      att.pen = 500