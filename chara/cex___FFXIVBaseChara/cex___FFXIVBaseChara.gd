extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
const Utils = globalData.infoDs["g_aFFXIVUtils"]
const TEXT = globalData.infoDs["g_bFFXIVText"]
const MGI = Chara.HurtType.MGI
const PHY = Chara.HurtType.PHY
const REAL = Chara.HurtType.REAL
const NORMAL = Chara.AtkType.NORMAL
const SKILL = Chara.AtkType.SKILL
const EFF = Chara.AtkType.EFF
var baseId = ""
var OCCUPATION = "Default"
var SoulExample = null

var BallisticSpeed = {
	"MeleeDPS": 500,
	"MagicDPS": 300,
	"DistanceDPS": 800,
	"Default": 450,
}

var FFHurtType = {
	"MeleeDPS": PHY,
	"MagicDPS": MGI,
	"DistanceDPS": PHY,
	"Default": PHY
}


func _extInit():
	._extInit()
	chaName = "基础角色"
	attCoe.atkRan = 1
	attCoe.maxHp = 1
	attCoe.atk = 1
	attCoe.mgiAtk = 1
	attCoe.def = 1
	attCoe.mgiDef = 1

func _onBattleStart():
	._onBattleStart()

func getAtkVal():
	match OCCUPATION:
		"MeleeDPS":
			return att.atk
		"MagicDPS":
			return att.mgiAtk * 0.5
		"DistanceDPS":
			return att.atk * 1.1
		"Default":
			return att.atk

# func canCri():
# 	match OCCUPATION:
# 		"MeleeDPS":
# 			return true
# 		"MagicDPS":
# 			return true
# 		"DistanceDPS":
# 			return true
# 		"Default":
# 			return true


func normalAtkChara(cha):
	var eff = newEff(atkEff, sprcPos)
	eff._initFlyCha(cha, BallisticSpeed[OCCUPATION])
	_onNormalAtk(cha)
	yield(eff, "onReach")
	if sys.isClass(cha, "Chara"):
		atkInfo.rate = 1
		atkInfo.isCri = false
		atkInfo.canCri = true
		atkInfo.atkVal = getAtkVal()
		atkInfo.hurtType = FFHurtType[OCCUPATION]
		atkInfo.atkType = NORMAL
		atkRun(cha)

func FFHurtChara(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)
