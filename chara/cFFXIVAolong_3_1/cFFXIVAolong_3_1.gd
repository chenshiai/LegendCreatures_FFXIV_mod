extends "../cFFXIVAolong_3/cFFXIVAolong_3.gd"

func _extInit():
	._extInit()
	chaName = "化身为影"
	lv = 3
	evos = []
	addCdSkill("skill_Assassinate", 26)
	addSkillTxt(TEXT.format("""{c_base}[生杀予夺]：冷却26s，强化一次忍术。{TPassive}自身伤害提高30%
[冰晶乱流之术]：[冰遁之术]强化：对目标造成{c_phy}[1200%]{/c}的魔法伤害
[劫火灭却之术]：[火遁之术]强化：对目标及周围2格范围内的敌人造成{c_phy}[700%]{/c}的魔法伤害{/c}"""))


func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	atkInfo.hurtVal *= 1.30

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Assassinate":
		Assassinate = true
		Utils.draw_efftext("活殺自在", position, "#ff99bb")
