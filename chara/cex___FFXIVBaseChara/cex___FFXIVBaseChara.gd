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
	"Protect": 500,
	"CloseCombat": 500,
	"Magic": 400,
	"LongRange": 800,
	"Treatment": 300,
	"Default": 450,
}

var FFHurtType = {
	"Protect": PHY,
	"CloseCombat": PHY,
	"Magic": MGI,
	"LongRange": PHY,
	"Treatment": MGI,
	"Default": PHY,
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


func getAtkVal():
	match OCCUPATION:
		"Protect":
			return att.atk
		"CloseCombat":
			return att.atk
		"Magic":
			return att.mgiAtk * 0.5
		"LongRange":
			return att.atk * 1.1
		"Treatment":
			return att.mgiAtk * 0.5
		"Default":
			return att.atk


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


func get_OCCUPATION():
	return OCCUPATION