extends Talent
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]
var Limit = globalData.infoDs["g_FFXIVLimitBreak"] # 极限技类
var HpBar = globalData.infoDs["g_FFXIVBossHpBar"] # boss血条类
var Retreat = globalData.infoDs["g_FFXIVRetreat"] # 退避机制
var FFXIVControl = globalData.infoDs["g_zFFXIVControl"] # 控制面板

var originBackground # 原版背景
var layer = 0 # 当前关卡数

const PROBABILITY = 15 # Boss出现的基本概率
const BOSS_LAYER = 27 # 在多少关之后概率动态调整
var probability = PROBABILITY # Boss出现的动态概率

func init():
	name = "Raid战斗记录"

func get_info():
	return TEXT.T_RAID % [lv * 4 + 20, (0.1 + lv * 0.01) * 100, lv, 5 + lv * 5]

func _connect():
	sys.main.player.maxHp += lv * 4+20
	sys.main.player.plusHp(lv * 4 + 20)
	sys.main.connect("onBattleReady", self, "come")
	sys.main.connect("onBattleStart", self, "run")
	sys.main.connect("onBattleEnd", self, "reward")
	originBackground = sys.main.get_node("scene/bg/bg").get_texture()
	HpBar.createHpBar()
	Limit.createLimitBreak()
	Retreat.initRetreat()
	FFXIVControl.createControl()

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
	if sys.main.player.hp <= sys.main.player.maxHp - lv:
		sys.main.player.plusHp(lv)
	sys.main.player.plusGold(5 + lv * 5)
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