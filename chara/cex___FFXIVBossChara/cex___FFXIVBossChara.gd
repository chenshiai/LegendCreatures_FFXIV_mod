extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

var layer # 关卡数
var battleDuration = 0 # 战斗时间
var TimeAxis = {} # 时间轴

# 敌方全部属性总和字典
var allAtt = {}
var E_maxHp = 0
var E_atk = 0
var E_mgiAtk = 0
var E_def = 0
var E_mgiDef = 0
var E_num = 0
var E_lv = 0

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
	addSkillTxt("[自适应调整]：该单位属性根据敌方战力自适应调整，拥有特定的技能时间轴")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	selfAdaption()

func _onBattleEnd():
	._onBattleEnd()
	reset()

# Boss自适应属性
func selfAdaption():
	layer = sys.main.guankaMsg.lvStep - 2
	allAtt = Utils.Calculation.getEnemyPower(self.team)
	E_atk = allAtt["atk"]
	E_mgiAtk = allAtt["mgiAtk"]
	E_def = allAtt["def"]
	E_mgiDef = allAtt["mgiDef"]
	E_maxHp = allAtt["maxHp"]
	E_num = allAtt["num"]
	E_lv = allAtt["lv"]
	
	attInfo.maxHp = (E_atk + E_mgiAtk) * layer
	attInfo.atk = (E_def + E_maxHp / 8) / E_num + layer
	attInfo.mgiAtk = (E_mgiDef + E_maxHp / 8) / E_num + layer
	attInfo.def = E_atk / E_num + layer
	attInfo.mgiDef = E_mgiAtk / E_num + layer

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
	TimeAxis = Utils.createTimeAxis(skillAxis)
	print("最终幻想14：Boss时间轴已创建")

func _upS():
	._upS()
	battleDuration += 1
	if TimeAxis.has(battleDuration):
		call_deferred(TimeAxis[battleDuration])