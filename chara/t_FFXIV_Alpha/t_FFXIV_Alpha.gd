extends Talent
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var Limit = globalData.infoDs["g_FFXIVLimitBreak"] # 极限技类
var HpBar = globalData.infoDs["g_FFXIVBossHpBar"] # boss血条类
var Chant = globalData.infoDs["g_FFXIVChant"]

var originBackground # 原版背景
var layer = 0 # 当前关卡数

const PROBABILITY = 15 # boss出现的基本概率
const BOSS_LAYER = 27 # 在多少关之后概率动态调整
var probability = PROBABILITY # Boss出现的动态概率

func init():
	name = "Raid战斗记录"

func get_info():
	return """从此刻开始体验经过夸大的激昂战斗
所有敌方双攻提高%d%%，战斗后额外获得%d金币
有概率出现强大的BOSS单位！！！
BOSS战可以使用极限技能了！！！
来自《最终幻想14》""" % [(0.1 + lv * 0.01) * 100, 5 + lv * 5]

func _connect():
	sys.main.connect("onBattleReady", self, "come")
	sys.main.connect("onBattleStart", self, "run")
	sys.main.connect("onBattleEnd", self, "reward")
	# sys.main.Player.connect("onAddCha", self, "addChara")
	originBackground = sys.main.get_node("scene/bg/bg").get_texture()
	HpBar.createHpBar()
	Limit.createLimitBreak()
	sys.newBaseMsg("极限技使用说明", """极限技，是可以扭转战局的绝招。
使用后会清空极限槽，请务必看清战场情况。
极限技可分为三种效果：
[防护]：短时间内给玩家单位减伤。
[进攻]：对敌方单体造成极大伤害。
[治疗]：为玩家单位恢复体力。
等级越高效果越强！！！""")

class Bf:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		isNegetive = false
		att.atkL += 0.1 + lv * 0.01
		att.mgiAtkL += 0.1 + lv * 0.01

func run():
	Limit.initLimitValue()
	for i in sys.main.btChas:
		if i.team == 2:
			i.addBuff(Bf.new(lv))

func reward():
	player.plusGold(25 + lv * 15)
	sys.main.get_node("scene/bg/bg").set_texture(originBackground)
	HpBar.setVisible(false)
	Limit.resetLimit()

func come():
	layer = sys.main.guankaMsg.lvStep - 2
	if layer > BOSS_LAYER:
		if sys.rndPer(probability):
			HpBar.setVisible(true)
			HpBar.setValue(100)
			probability = PROBABILITY
			clear(null)
			var n = sys.rndRan(0, 3)
			match n:
				0:
					Utils.backGroundChange("/img/SpaceTimeSlit.png")
					addUnit("cex___FFXIVOmegaF")
				1:
					Utils.backGroundChange("/img/SpaceTimeSlit.png")
					addUnit("cex___FFXIVOmegaM")
				2:
					Utils.backGroundChange("/img/SpaceTimeSlit1.png")
					addUnit("cex___FFXIVOmega")
				3:
					Utils.backGroundChange("/img/PerfectThrone.png")
					addUnit("cex___FFXIVInnocence")
		else:
			probability += 1

func clear(bosscha):
	var cha
	for i in range(0,8):
		for j in range(0,5):
			cha = sys.main.matCha(Vector2(i, j))
			if cha != null and cha.team != 1 and cha != bosscha:
				sys.main.delMatChara(cha)

func addUnit(id):
	var cha
	cha = sys.main.newChara(id, 2)
	sys.main.map.add_child(cha)
	sys.main.setMatCha(Vector2(6, 2), cha)
	cha.isDeath = true
	cha.revive(cha.att.maxHp)
	cha.connect("onHurtEnd", HpBar, "hpDown")
	cha.connect("onAtkChara", Limit, "limitBreakUp")
	return cha