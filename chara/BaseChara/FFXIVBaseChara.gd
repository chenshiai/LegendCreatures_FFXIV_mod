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
var SKILL_CRI = false

var BallisticSpeed = {
	"Protect": 600,
	"CloseCombat": 700,
	"Magic": 500,
	"LongRange": 1000,
	"Treatment": 400,
	"Default": 500,
}

var FFHurtType = {
	"Protect": PHY,
	"CloseCombat": PHY,
	"Magic": MGI,
	"LongRange": PHY,
	"Treatment": MGI,
	"Default": PHY,
}


func _init():
	if not is_connected("onPressed", self, "show_OCCUPATION"):
		connect("onPressed", self, "show_OCCUPATION")


func _extInit():
	._extInit()
	chaName = "基础角色"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1

func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == SKILL and SKILL_CRI:
		atkInfo.canCri = true


func getAtkVal():
	match OCCUPATION:
		"Protect":
			return att.atk
		"CloseCombat":
			return att.atk * 1.1
		"Magic":
			return att.mgiAtk * 0.6
		"LongRange":
			return att.atk * 1.1
		"Treatment":
			return att.mgiAtk * 0.5
		"Default":
			return att.atk


func set_AtkInfo():
	atkInfo.rate = 1
	atkInfo.isCri = false
	atkInfo.canCri = true
	atkInfo.atkVal = getAtkVal()
	atkInfo.hurtType = FFHurtType[OCCUPATION]
	atkInfo.atkType = NORMAL


func normalAtkChara(cha):
	var eff = newEff(atkEff, sprcPos)
	eff._initFlyCha(cha, BallisticSpeed[OCCUPATION])
	_onNormalAtk(cha)
	set_AtkInfo()
	yield(eff, "onReach")
	atkRun(cha)

func FFHurtChara(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)


func get_OCCUPATION():
	return OCCUPATION


func show_OCCUPATION(chara):
	var regex = RegEx.new()
	regex.compile("\\[/color\\]")
	var charaInfo = sys.get_node("/root/topUi/charaInfoMsg")
	var txt = charaInfo.get_node("txt")
	txt.bbcode_text = regex.sub(txt.bbcode_text, "[/color]	" + TEXT.Occupation[OCCUPATION])
