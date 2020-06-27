# 最终幻想14 Boss模板文件
# 版本号 2020/06/25 0.0.2
extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
const Utils = globalData.infoDs["g_aFFXIVUtils"]
const TEXT = globalData.infoDs["g_bFFXIVText"]
var Retreat = globalData.infoDs["g_FFXIVRetreat"] # 退避机制
var FFControl = null
var Path = ""

var baseId = ""
var reward = true # 是否开启死亡奖励
var layer # 当前关卡数
var battleDuration = 0 # 战斗时间

var TimeAxis = {} # 时间轴
var HateTarget # 暂存boss当前仇恨目标
var Chant = Utils.FFXIVClass.Chant.new() # 新建一个咏唱条

# 敌方全部属性总和字典
var allAtt = {}
var E_maxHp = 1
var E_atk = 1
var E_mgiAtk = 1
var E_def = 1
var E_mgiDef = 1
var E_num = 1
var E_lv = 1
var E_spd = 1

func _extInit():
	._extInit()
	name = "boss模板"
	attCoe.atkRan = 1
	attCoe.maxHp = 1
	attCoe.atk = 1
	attCoe.mgiAtk = 1
	attCoe.def = 1
	attCoe.mgiDef = 1
	evos = []
	lv = 1
	atkEff = "atk_dao"
	HateTarget = null
	addSkillTxt(TEXT.format(TEXT.BOSS_DEFAULT))

func _onBattleStart():
	._onBattleStart()
	selfAdaption()
	reward = true

func _onBattleEnd():
	._onBattleEnd()
	reset()

# 克制细剑 烧灼的百分比伤害
func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	if atkInfo.atkType == Chara.AtkType.EFF and atkInfo.hurtVal > att.maxHp * 0.005:
		atkInfo.hurtVal = att.maxHp * 0.005 * (1 - (att.def + att.mgiDef) / (att.def + att.mgiDef + 200))

# 团灭玩家，boss自杀
func _onKillChara(atkInfo):
	._onKillChara(atkInfo)
	var tarCha = atkInfo.hitCha
	if tarCha.team == 1:
		var count = 0
		for cha in getAllChas(1):
			if !cha.isDeath:
				count += 1

		if count == 0:
			reward = false
			tarCha.newChara("cex___FFXIVSummon", tarCha.cell)
			sys.newBaseMsg(TEXT.Insurance.title, TEXT.Insurance.content)
			FFHurtChara(self, att.maxHp * 2, Chara.HurtType.REAL, Chara.AtkType.SKILL)

# 死亡奖励
func _onDeath(atkInfo):
	._onDeath(atkInfo)
	if reward:
		var item = sys.newItem("i_FFXIVSoulCrystal")
		sys.main.player.addItem(item)

func FFHurtChara(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)
	
# Boss自适应属性
func selfAdaption():
	if self.team == 2:
		layer = sys.main.guankaMsg.lvStep + 40
		allAtt = Utils.Calculation.getEnemyPower(self.team)
		E_atk = allAtt.atk
		E_mgiAtk = allAtt.mgiAtk
		E_def = allAtt.def
		E_mgiDef = allAtt.mgiDef
		E_maxHp = allAtt.maxHp
		E_spd = allAtt.spd
		E_num = allAtt.num
		E_lv = allAtt.lv
		attInfo.maxHp = (E_atk + E_mgiAtk) / E_num * layer * 10
		attInfo.atk = (E_def + E_maxHp / 8) / E_num + layer * 3
		attInfo.mgiAtk = (E_mgiDef + E_maxHp / 8) / E_num + layer * 3
		attInfo.def = (E_atk + layer * 2) / E_num
		attInfo.mgiDef = (E_mgiAtk + layer * 2) / E_num
		upAtt()

# 战后重置属性
func reset():
	battleDuration = 0
	att.maxHp = 1
	att.hp = 1
	att.atk = 1
	att.mgiAtk = 1
	att.def = 1
	att.mgiDef = 1


# 修改普通攻击
func normalAtkChara(cha):
	var eff = newEff(atkEff, sprcPos)
	eff._initFlyCha(cha, 500)
	_onNormalAtk(cha)
	yield(eff, "onReach")
	if sys.isClass(cha, "Chara"):
		atkInfo.rate = 1
		atkInfo.isCri = false
		atkInfo.canCri = true
		if cha.att.maxHp * 0.3 < att.atk:
			atkInfo.atkVal = att.atk
		else:
			atkInfo.atkVal = cha.att.maxHp * 0.3
		atkInfo.hurtType = HurtType.PHY
		atkInfo.atkType = AtkType.NORMAL
		atkRun(cha)


# 创建时间轴
func set_time_axis(skillAxis):
	TimeAxis = Utils.create_timeAxis(skillAxis)

func _upS():
	._upS()
	battleDuration += 1
	if TimeAxis.has(battleDuration):
		call_deferred(TimeAxis[battleDuration])

# 拼接当前文件的路径
func set_path(id: String):
	Path = chaData.infoDs[id].dir + "/%s/files" % [id]
