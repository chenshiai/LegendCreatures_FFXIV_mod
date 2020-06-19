extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _extInit():
	._extInit()
	OCCUPATION = "MeleeDPS"
	chaName = "绝枪战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4.5
	attCoe.atk = 4
	attCoe.def = 4.3
	attCoe.mgiDef = 4.3
	lv = 2
	evos = ["cFFXIVHumen_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_BowShock", 9)
	addSkillTxt(TEXT.format("""[王室亲卫]：『{TPassive}』受到的伤害减少20%
[弓形冲波]：冷却9s，对周围2格的敌人造成[260%]的{TPhyHurt}，并附加4层[烧灼]"""))

const BOWSHOCK_PW = 2.60 # 弓形冲波威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BowShock":
		bowShock()

# 弓形冲波
func bowShock():
	var chas = getCellChas(cell, 2, 1)
	for i in chas:
		FFHurtChara(i, att.atk * BOWSHOCK_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
		i.addBuff(b_shaoZhuo.new(4))

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80
