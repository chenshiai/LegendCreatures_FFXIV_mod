extends "../cFFXIVAolong_2_1/cFFXIVAolong_2_1.gd"

const SHOHA_PW = 4 # 照破威力
var ShohaCount = 0


func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4.3
	attCoe.atk = 5
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))
	if not is_connected("swordPpressure", self, "Shoha"):
		connect("swordPpressure", self, "Shoha")


func _onBattleStart():
	._onBattleStart()
	ShohaCount = 0


func Shoha():
	ShohaCount += 1
	if ShohaCount >= 3:
		FFHurtChara(aiCha, att.atk * SHOHA_PW, PHY, SKILL)
		ShohaCount = 0

