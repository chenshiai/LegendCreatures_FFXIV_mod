extends "../cNoveaPilot_1/cNoveaPilot_1.gd"

var SkillText_1_2 = TEXT.format("""{c_skill}[登陆专精]{/c}：飞船起降时所消耗的能源降低{c_base}5%{/c}，最多可叠加三次{c_base}(15%){/c}
{c_skill}[战斗迂回]{/c}：战斗开始时，己方所有飞行单位获得{c_skill}10%{/c}的闪避，{c_dark}暗物质攻击{/c}除外，不可叠加。""")

func _extInit():
	._extInit()
	chaName = "徘徊者"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_1_2)