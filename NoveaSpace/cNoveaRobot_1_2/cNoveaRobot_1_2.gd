extends "../cNoveaRobot_1/cNoveaRobot_1.gd"

var SkillText_1_2 = "{c_skill}[模块升级]{/c}：在星球上采集到稀有资源的概率提高{c_base}5%{/c}，最多可叠加3次{c_base}(15%){/c}（同类效果取最高）"

func _extInit():
	._extInit()
	chaName = "微型采集机器人"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_1_2))
