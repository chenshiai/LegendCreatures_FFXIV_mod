extends Talent

func init():
	name = "光之加护"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(LightHard.new(lv))

func get_info():
	return "战斗开始后，己方所有角色双抗提高 %d%%\n“海德林的光之信徒啊！随着这黑暗的要塞一起消失吧！！！” ———— 拉哈布雷亚" % [(0.1 + lv * 0.01)*100]

class LightHard:
	extends Buff

	func _init(lv):
		attInit()
		id = "LightHard"
		isNegetive = false
		att.defL = 0.1 + lv * 0.01
		att.mgiDefL = 0.1 + lv * 0.01
		self.lv = lv