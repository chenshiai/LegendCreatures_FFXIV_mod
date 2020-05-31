extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "绝枪战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4.3
	attCoe.atk = 4
	attCoe.def = 4.3
	attCoe.mgiDef = 4.3
	lv = 2
	evos = ["cFFXIVHumen_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_BowShock", 9)
	addSkillTxt("""[王室亲卫]：被动，受到的伤害减少10%
[弓形冲波]：ÇÐ9s，对周围1格的敌人造成[260%]的物理伤害，并附加4层[烧灼]""")

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
	var chas = getCellChas(cell, 1)
	for i in chas:
		if i != self:
			hurtChara(i, att.atk * BOWSHOCK_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			i.addBuff(b_shaoZhuo.new(4))

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.90
