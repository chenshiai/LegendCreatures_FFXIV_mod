extends "../cNoveaPilot/cNoveaPilot.gd"

var SkillText_1 = TEXT.format("{c_skill}[航空专精]{/c}：航行所消耗的能源降低{c_base}5%{/c}，最多可叠加三次{c_base}(15%){/c}（同类效果取最高）")

func _extInit():
	._extInit()
	chaName = "飞行专员"
	lv = 2
	evos = ["cNoveaPilot_1_1", "cNoveaPilot_1_2"]
	atkEff = "atk_dao"
	addSkillTxt(SkillText_1)