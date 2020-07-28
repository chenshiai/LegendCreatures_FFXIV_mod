extends "../BaseChara/FFXIVBaseChara.gd"
const BOWSHOCK_PW = 2.60 # 弓形冲波威力

func _extInit():
	._extInit()
	OCCUPATION = "Protect"
	chaName = tr("FFXIVHumen_2-name_1")
	attCoe.atkRan = 1
	attCoe.maxHp = 4.5
	attCoe.atk = 4
	attCoe.def = 4.3
	attCoe.mgiDef = 4.3
	lv = 2
	evos = ["cFFXIVHumen_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_BowShock", 9)
	addSkillTxt("FFXIVHumen_2-skill_text")


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BowShock":
		bowShock()


func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80


# 弓形冲波
func bowShock():
	var chas = getCellChas(cell, 2, 1)
	for i in chas:
		FFHurtChara(i, att.atk * BOWSHOCK_PW, PHY, SKILL)
		i.addBuff(b_shaoZhuo.new(4))

