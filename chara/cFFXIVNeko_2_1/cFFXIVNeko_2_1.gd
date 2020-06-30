extends "../cFFXIVNeko_2/cFFXIVNeko_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "首席之唤"
	lv = 3
	evos = []
	addCdSkill("skill_Dreadwyrm", 24)
	addSkillTxt(TEXT.format("""[龙神附体]：冷却24s，自身魔法强度提高20%，持续8s
[龙神迸发]：{TPassive}龙神附体时，对目标及周围2格内的敌人造成[700%]法强的{TMgiHurt}"""))

const ENKINDLEBAHAMUT_PW = 7 # 龙神迸发威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Dreadwyrm":
		dreadwyrm()
		enkindleBahamut(self.lv)

func dreadwyrm():
	BUFF_LIST.b_Dreadwyrm.new({"cha": self, "dur": 8})

func enkindleBahamut(lv):
	var cell = aiCha.cell
	var chas = getCellChas(cell, 2)
	if lv == 4:
		Utils.draw_effect("phoenix", position, Vector2(40, -40), 15, 2)
	Utils.draw_effect("nuclearExplosion", aiCha.position, Vector2(0, -30), 8, 2)
	yield(reTimer(0.5), "timeout")
	
	for i in chas:
		if i != null:
			if lv == 4:
				FFHurtChara(i, att.mgiAtk * (ENKINDLEBAHAMUT_PW + 0.60), Chara.HurtType.MGI, Chara.AtkType.SKILL)
				i.addBuff(b_shaoZhuo.new(20))
			else:
				FFHurtChara(i, att.mgiAtk * ENKINDLEBAHAMUT_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

