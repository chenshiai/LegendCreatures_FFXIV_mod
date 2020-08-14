extends "../cNoveaRobot_1/cNoveaRobot_1.gd"

var SkillText_1_1 = "{c_skill}[采集程序升级]{/c}：【机器采集】的资源获取量提高{c_base}15%{/c}，最多可叠加3次{c_base}(45%){/c}（同类效果取最高）"

func _extInit():
	._extInit()
	chaName = "高效采集机器人"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_1_1))
