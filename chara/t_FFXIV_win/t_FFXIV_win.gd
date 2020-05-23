extends Talent

const TIMEOUT = 240 # 0级的倒计时
func init():
	name = "光之加护"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(TIMEOUT))

func get_info():
	return "敏菲利亚喊你回一趟沙之家，赶紧结束战斗吧！当战斗时间超过120秒后，己方角色的攻击力提升500%，并获得500点护甲穿透。此天赋不需要提升等级"

class Bf:
	extends Buff

	func _init(lv):
		attInit()
		isNegetive = false
		life = lv
	
	func _upS():
		if life < 120:
			att.atkL = 5
			att.pen = 500
		if life < 1: life = 5