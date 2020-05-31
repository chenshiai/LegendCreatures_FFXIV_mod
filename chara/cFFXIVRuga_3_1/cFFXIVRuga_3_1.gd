extends "../cFFXIVRuga_3/cFFXIVRuga_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "咆哮之火"
	lv = 3
	evos = []
	addCdSkill("skill_Drill", 12)
	addSkillTxt("[钻头]：ÇÐ12s，对目标造成[400%]的物理伤害")
	addSkillTxt("[火焰喷射器]：被动，普通攻击会对目标及其周围一格的敌人附加2层[烧灼]")

const DRILL_PW = 4 # 钻头威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Drill":
		drill()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	var chas = getCellChas(atkInfo.hitCha.cell, 1)
	for i in chas:
			if i != self:
				i.addBuff(b_shaoZhuo.new(2))

func drill():
	if aiCha != null:
		hurtChara(aiCha, att.atk * DRILL_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)