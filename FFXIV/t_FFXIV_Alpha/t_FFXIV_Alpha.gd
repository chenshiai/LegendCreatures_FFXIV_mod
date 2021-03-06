extends Talent
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]
var FFChara = globalData.infoDs["g_FFXIVChara"] # 角色相关类
var RandomItem = load("%s%s" % [Utils.Path, "/FFXIVItem/randomItem.gd"])
var FFControl # 控制面板

var originBackground # 原版背景
var layer = 0 # 当前关卡数
var lastLayer = 0 # 上一次出现boss的层数

const PROBABILITY = 100 # Boss出现的基本概率
const BOSS_LAYER = 27 # 在多少关之后概率动态调整
var probability = PROBABILITY # Boss出现的动态概率

const CharaList = ["cFFXIVAolong_1_1", "cFFXIVAolong_2_1", "cFFXIVAolong_3_1",
	"cFFXIVHumen_1_1", "cFFXIVHumen_2_1", "cFFXIVHumen_3_1",
	"cFFXIVLarafel_1_1", "cFFXIVLarafel_2_1", "cFFXIVLarafel_3_1",
	"cFFXIVNeko_1_1", "cFFXIVNeko_2_1", "cFFXIVNeko_3_1",
	"cFFXIVRuga_1_1", "cFFXIVRuga_2_1", "cFFXIVRuga_3_1",
	"cFFXIVSpirit_1_1", "cFFXIVSpirit_2_1", "cFFXIVSpirit_3_1", "cFFXIV_Tatalu"]


func init():
	name = "Raid战斗记录"

func get_info():
	return TEXT.T_RAID % [lv * 4 + 20, (0.05 + lv * 0.01) * 100, lv, 5 + lv * 5]

func _connect():
	FFControl = Utils.getFFControl()
	originBackground = sys.main.get_node("scene/bg/bg").get_texture()

	sys.main.player.maxHp += lv * 4 + 20
	sys.main.player.plusHp(lv * 4 + 20)
	sys.main.connect("onBattleReady", self, "come")
	sys.main.connect("onBattleStart", self, "run")
	sys.main.connect("onBattleEnd", self, "reward")
	FFChara.openDeathList()
	
	# 测试生成角色用
	# for id in CharaList:
	# 	var cha = sys.main.newChara(id, 1)
	# 	sys.main.player.addCha(cha)

class Raid:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		isNegetive = false
		att.atkL = 0.05 + lv * 0.01
		att.mgiAtkL = 0.05 + lv * 0.01

func run():
	FFControl.Limit.init_limitBreak()
	for i in sys.main.btChas:
		if i.team == 2:
			i.addBuff(Raid.new(lv))

func reward():
	if sys.main.player.hp <= sys.main.player.maxHp - lv:
		sys.main.player.plusHp(lv)
	sys.main.player.plusGold(5 + lv * 5)
	sys.main.get_node("scene/bg/bg").set_texture(originBackground)
	
	if sys.rndPer(13):
		var item = RandomItem.getItem()
		sys.main.player.addItem(item)
		sys.newBaseMsg("获得了上古武器！", "获得了装备%s" % [item.name])

	FFControl.HpBar.hidden()
	FFControl.Limit.reset_limitBreak()
	FFControl.FFMusic.reset()
	FFControl.showControl()

func come():
	layer = sys.main.guankaMsg.lvStep - 2
	if layer > BOSS_LAYER and layer != lastLayer:
		if sys.rndPer(probability):
			lastLayer = layer
			probability = PROBABILITY

			var cha = FFChara.rndRanBoss()
			if cha != null:
				FFControl.HpBar.show()
				cha.connect("onHurtEnd", FFControl.HpBar, "hpDown")
				cha.connect("onAtkChara", FFControl.Limit, "limitBreak_up")

		else:
			probability += 1
