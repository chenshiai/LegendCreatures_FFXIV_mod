extends "../cNoveaPilot_1/cNoveaPilot_1.gd"

var SkillText_1_1 = TEXT.format("{c_skill}[星际航行大师]{/c}：航行所消耗的能源降低{c_base}15%{/c}，最多可叠加三次{c_base}(45%){/c}（同类效果取最高）")

func _extInit():
	._extInit()
	chaName = "领航员"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_1_1)