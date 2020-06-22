extends Talent
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]
var Limit = globalData.infoDs["g_FFXIVLimitBreak"] # 极限技类
var HpBar = globalData.infoDs["g_FFXIVBossHpBar"] # boss血条类
var FFChara = globalData.infoDs["g_FFXIVChara"] # 角色相关类
var Retreat = globalData.infoDs["g_FFXIVRetreat"] # 退避机制
var FFControl # 控制面板

var originBackground # 原版背景
var layer = 0 # 当前关卡数
var lastLayer = 0 # 上一次出现boss的层数

const PROBABILITY = 15 # Boss出现的基本概率
const BOSS_LAYER = 27 # 在多少关之后概率动态调整
var probability = PROBABILITY # Boss出现的动态概率

func init():
	name = "Raid战斗记录"

func get_info():
	return TEXT.T_RAID % [lv * 4 + 20, (0.05 + lv * 0.01) * 100, lv, 5 + lv * 5]

func _connect():
	sys.main.player.maxHp += lv * 4 + 20
	sys.main.player.plusHp(lv * 4 + 20)
	sys.main.connect("onBattleReady", self, "come")
	sys.main.connect("onBattleStart", self, "run")
	sys.main.connect("onBattleEnd", self, "reward")
	originBackground = sys.main.get_node("scene/bg/bg").get_texture()
	HpBar.createHpBar()
	Limit.draw_limitBreak()
	Retreat.initRetreat()
	FFChara.openDeathList()

	FFControl = Utils.FFControl.new()
	FFControl.createControl()

class Raid:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		isNegetive = false
		att.atkL = 0.05 + lv * 0.01
		att.mgiAtkL = 0.05 + lv * 0.01

func run():
	Limit.init_limitBreak()
	for i in sys.main.btChas:
		if i.team == 2:
			i.addBuff(Raid.new(lv))

func reward():
	if sys.main.player.hp <= sys.main.player.maxHp - lv:
		sys.main.player.plusHp(lv)
	sys.main.player.plusGold(5 + lv * 5)
	sys.main.get_node("scene/bg/bg").set_texture(originBackground)
	HpBar.hidden()
	Limit.reset_limitBreak()

func come():
	layer = sys.main.guankaMsg.lvStep - 2
	if layer > BOSS_LAYER and layer != lastLayer:
		if sys.rndPer(probability):
			lastLayer = layer
			probability = PROBABILITY
			HpBar.show()

			var cha = FFChara.rndRanBoss()
			cha.connect("onHurtEnd", HpBar, "hpDown")
			cha.connect("onAtkChara", Limit, "limitBreak_up")

		else:
			probability += 1
