extends "../cNoveaPilot_2/cNoveaPilot_2.gd"

var SkillText_2_2 = TEXT.format("""{c_skill}[对空专精]{/c}：专精支援的飞行兵，对飞行单位造成的伤害提高至{c_base}200%{/c}
{c_skill}[地面支援]{/c}：战斗开始时，己方地面单位攻击力提高{c_base}10%{/c}，不可叠加""")

func _extInit():
	._extInit()
	chaName = "空&地支援兵"
	lv = 3
	attCoe.maxHp -= 2
	attCoe.atk -= 4
	attCoe.mgiAtk -= 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_2_2)
