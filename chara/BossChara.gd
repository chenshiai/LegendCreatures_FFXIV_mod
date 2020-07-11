# 最终幻想14 Boss模板文件
# 版本号 2020/07/11 0.1.3
extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"] # Buff列表
const Utils = globalData.infoDs["g_aFFXIVUtils"] # FFXIV全局工具
const TEXT = globalData.infoDs["g_bFFXIVText"] # FFXIV全局文本
const Retreat = globalData.infoDs["g_FFXIVRetreat"] # 退避机制
const FFChara = globalData.infoDs["g_FFXIVChara"] # 角色相关

var FFControl = null # 控制器变量
var Path = "" # 当前文件路径

var baseId = ""
var reward = true # 是否开启死亡奖励
var layer # 当前关卡数
var battleDuration = 0 # 战斗时间
var STAGE = "p1" # p1 p2 p3 ...阶段 特别申明 p0表示战斗结束

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

# -------------------- boss生命周期 ---------------------------
func _init():
	# 生成实例时，从Utils获取控制器
	FFControl = Utils.getFFControl()


func _onBattleStart():
	# 战斗开始时，属性自适应
	selfAdaption()


func _onBattleEnd():
	# 战斗结束后，属性重置
	reset()


func _onHurt(atkInfo):
	# 克制细剑,流血,烧灼等一系列特效伤害
	if atkInfo.atkType == Chara.AtkType.EFF and atkInfo.hurtVal > att.maxHp * 0.005:
		atkInfo.hurtVal = att.maxHp * 0.005 * (1 - (att.def + att.mgiDef) / (att.def + att.mgiDef + 200))


func _onCharaDel(cha):
	# 玩家角色，给玩家回复一定的血量
	healPlayer(cha)

	# 团灭玩家，Boss需要自杀来确保游戏不会结束
	if cha.team == 1:
		var count = 0
		for i in sys.main.btChas:
			if !i.isDeath and i.team == 1:
				count += 1

		if count == 0:
			cha.newChara("cFFXIV_zTatalu", cha.cell)
			killSelf()


func _onDeath(atkInfo):
	# 死亡时打断读条
	Chant.interrupt()
	# 死亡时给予玩家奖励
	rewardToPlay()


func _upS():
	# Boss时间轴的触发
	battleDuration += 1
	if TimeAxis.has(battleDuration):
		call_deferred(TimeAxis[battleDuration])


# -------------------- boss基础方法实现 ---------------------------
func normalAtkChara(cha):
	# 修改普通攻击
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


func FFHurtChara(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)


func complexHurt(chas, atkVal, hurtType, atkType):
	for cha in chas:
		FFHurtChara(cha, atkVal, hurtType, atkType)


func selfAdaption():
	# Boss只有在电脑方才可以使用自适应属性
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
		attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 750
		attInfo.atk = (E_def + E_maxHp / 8) / E_num + layer * 3
		attInfo.mgiAtk = (E_mgiDef + E_maxHp / 8) / E_num + layer * 3
		attInfo.def = (E_atk + layer * 2) / E_num
		attInfo.mgiDef = (E_mgiAtk + layer * 2) / E_num
		upAtt()


func reset():
	# 战后重置属性
	battleDuration = 0
	att.maxHp = 1
	att.hp = 1
	att.atk = 1
	att.mgiAtk = 1
	att.def = 1
	att.mgiDef = 1


func rewardToPlay():
	if self.reward:
		var item = sys.newItem("i_FFXIVSoulCrystal")
		sys.main.player.addItem(item)
		sys.newBaseMsg(TEXT.Reward.title, TEXT.Reward.content)


func closeReward():
	# 关闭奖励
	self.reward = false


func set_time_axis(skillAxis):
	# 创建时间轴
	TimeAxis = Utils.create_timeAxis(skillAxis)


func set_path(id: String):
	# 拼接当前文件的路径
	Path = chaData.infoDs[id].dir + "/%s/files" % [id]


func Ace():
	# 团灭
	for cha in getAllChas(1):
		cha.att.hp = -1
		hurtChara(cha, 100, Chara.HurtType.REAL, Chara.AtkType.EFF)


func healPlayer(cha):
	# 回复玩家生命
	if !cha.isSumm and cha.team == 1:
		match cha.lv:
			1: sys.main.player.hp += 1
			2: sys.main.player.hp += 2
			3: sys.main.player.hp += 3
			4: sys.main.player.hp += 5


func killSelf():
	# Boss自杀
	STAGE = "p0"
	closeReward()
	Chant.interrupt()
	for i in getAllChas(2):
		FFHurtChara(i, att.maxHp * 2, Chara.HurtType.REAL, Chara.AtkType.SKILL)
	sys.newBaseMsg(TEXT.Insurance.title, TEXT.Insurance.content)