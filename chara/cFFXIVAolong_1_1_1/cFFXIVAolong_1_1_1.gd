extends "../cFFXIVAolong_1_1/cFFXIVAolong_1_1.gd"

func _extInit():
	._extInit()
	chaName = "希德勒格-传奇"
	attCoe.maxHp = 9
	attCoe.atk = 4.6
	attCoe.def = 5.9
	attCoe.mgiDef = 6.5
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[掠影示现]：『{TPassive}』令英雄的掠影变为实体与自身并肩作战，与本体同步攻击，造成本体的[30%]的伤害，自身最大生命值提高"))

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType != AtkType.EFF:
		atkInfo.hurtVal *= 1.30