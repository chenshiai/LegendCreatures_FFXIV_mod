extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
const Utils = globalData.infoDs["g_aFFXIVUtils"]
const Chant = globalData.infoDs["g_FFXIVChant"]
const TEXT = globalData.infoDs["g_bFFXIVText"]

var OCCUPATION = "Default"
var BallisticSpeed = {
	"MeleeDPS": 500,
	"MagicDPS": 700,
	"DistanceDPS": 1000,
	"Default": 450,
}

var FFHurtType = {
	"MeleeDPS": HurtType.PHY,
	"MagicDPS": HurtType.MGI,
	"DistanceDPS": HurtType.PHY,
	"Default": HurtType.PHY
}

var AtkSpd = {
	"MeleeDPS": 0,
	"MagicDPS": -0.4,
	"DistanceDPS": 0.2,
	"Default": 0
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
	attAdd.spd = AtkSpd[OCCUPATION]

func getAtkVal():
	match OCCUPATION:
		"MeleeDPS": 
			return att.atk
		"MagicDPS":
			return att.mgiAtk * 0.6
		"DistanceDPS":
			return att.atk * 1.1
		"Default":
			return att.atk

func canCri():
	match OCCUPATION:
		"MeleeDPS": 
			return true
		"MagicDPS":
			return false
		"DistanceDPS":
			return true
		"Default":
			return true


func normalAtkChara(cha):
	var eff = newEff(atkEff, sprcPos)
	eff._initFlyCha(cha, BallisticSpeed[OCCUPATION])
	_onNormalAtk(cha)
	yield(eff, "onReach")
	if sys.isClass(cha, "Chara"):
		atkInfo.rate = 1
		atkInfo.isCri = false
		atkInfo.canCri = canCri()
		atkInfo.atkVal = getAtkVal()
		atkInfo.hurtType = FFHurtType[OCCUPATION]
		atkInfo.atkType = AtkType.NORMAL
		atkRun(cha)

func FFHurtChara(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)
