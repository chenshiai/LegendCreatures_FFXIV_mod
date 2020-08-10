extends "../BaseChara/FFXIVBaseChara.gd"

const PLUSHP = 0.05 # 恢复量
const BLOODSPILLER_PW = 2.90 # 血溅倍率
var atkCount = 0 # 攻击次数
var darkCount = 0 # 暗血

const meterage = {
	"zh_CN": "暗血",
	"en": "Blackblood",
	"ja": "暗血"
}
var locale = TranslationServer.get_locale()

func _init():
	logoImgName = "DarkKnight"

func _extInit():
	._extInit()
	OCCUPATION = "Protect"
	chaName = tr("FFXIVAolong_1-name_1")
	attCoe.atkRan = 1
	attCoe.maxHp = 5
	attCoe.atk = 3.6
	attCoe.def = 3.6
	attCoe.mgiDef = 4.4
	attAdd.mgiDefL = 0.1
	lv = 2
	evos = ["cFFXIVAolong_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Bloodspiller", 10)
	addSkillTxt("%s: %d / 700" % [meterage[locale], 0])
	addSkillTxt("FFXIVAolong_1-skill_text")

func _onBattleStart():
	._onBattleStart()
	atkCount = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Bloodspiller":
		bloodspiller()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == NORMAL:
		atkCount += 1
		if atkCount == 3:
			atkCount = 0
			atkInfo.atkVal *= 1.1
			plusHp(att.maxHp * PLUSHP)

func bloodspiller():
	FFHurtChara(aiCha, att.atk * BLOODSPILLER_PW, PHY, SKILL)