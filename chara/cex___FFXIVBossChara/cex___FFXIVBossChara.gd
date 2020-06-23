extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var Chant = Utils.Chant.new()

var reward = true # 是否开启死亡奖励
var layer # 关卡数
var battleDuration = 0 # 战斗时间
var TimeAxis = {} # 时间轴
var HateTarget # 暂存boss当前仇恨目标
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

const DefaultTxt = """{c_base}[自适应]：该单位属性根据敌方战力自适应调整，拥有特定的技能时间轴。{/c}"""

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
	addSkillTxt(TEXT.format(DefaultTxt))

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	selfAdaption()
	reward = true

func _onBattleEnd():
	._onBattleEnd()
	reset()

# Boss自适应属性
func selfAdaption():
	if self.team == 2:
		layer = sys.main.guankaMsg.lvStep + 20
		allAtt = Utils.Calculation.getEnemyPower(self.team)
		E_atk = allAtt.atk
		E_mgiAtk = allAtt.mgiAtk
		E_def = allAtt.def
		E_mgiDef = allAtt.mgiDef
		E_maxHp = allAtt.maxHp
		E_spd = allAtt.spd
		E_num = allAtt.num
		E_lv = allAtt.lv
		attInfo.maxHp = (E_atk + E_mgiAtk) * layer * 2 / E_num
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

func setTimeAxis(skillAxis):
	TimeAxis = Utils.create_timeAxis(skillAxis)

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	if atkInfo.atkType == Chara.AtkType.EFF and atkInfo.hurtVal > att.maxHp * 0.005:
		atkInfo.hurtVal = att.maxHp * 0.005 * (1 - (att.def + att.mgiDef) / (att.def + att.mgiDef + 200))

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

func _upS():
	._upS()
	battleDuration += 1
	if TimeAxis.has(battleDuration):
		call_deferred(TimeAxis[battleDuration])

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	var tarCha = atkInfo.hitCha
	if atkInfo.hurtVal >= tarCha.att.hp and tarCha.team == 1:
		var count = 0
		for cha in getAllChas(1):
			if !cha.isDeath:
				count += 1

		if count == 1:
			reward = false
			tarCha.newChara("cex___FFXIVSummon", tarCha.cell)
			sys.newBaseMsg(TEXT.Insurance.title, TEXT.Insurance.content)
			FFHurtChara(self, att.maxHp * 2, Chara.HurtType.REAL, Chara.AtkType.SKILL)
		else:
			match tarCha.lv:
				1: sys.main.player.hp += 1
				2: sys.main.player.hp += 2
				3: sys.main.player.hp += 5
				4: sys.main.player.hp += 7

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	if reward:
		var item = sys.newItem("i_FFXIVSoulCrystal")
		sys.main.player.addItem(item)
	