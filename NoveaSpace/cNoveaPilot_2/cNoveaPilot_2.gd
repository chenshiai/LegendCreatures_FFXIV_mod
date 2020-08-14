extends "../cNoveaPilot/cNoveaPilot.gd"

var SkillText_2 = TEXT.format("""{c_skill}[战斗强化]{/c}：经过军事训练后的飞行员，战斗开始时，己方所有飞行单位的攻击力提高{c_base}8%{/c}，在备战区可以生效，可以叠加（同类效果取最高）
{c_skill}[体能强化]{/c}：经过军事训练后的飞行员，最大生命值以及攻击力提升""")

func _extInit():
	._extInit()
	chaName = "飞行兵"
	lv = 2
	attCoe.maxHp += 1
	attCoe.atk += 2
	attCoe.mgiAtk += 1
	evos = ["cNoveaPilot_2_1", "cNoveaPilot_2_2"]
	atkEff = "atk_dao"
	addSkillTxt(SkillText_2)
