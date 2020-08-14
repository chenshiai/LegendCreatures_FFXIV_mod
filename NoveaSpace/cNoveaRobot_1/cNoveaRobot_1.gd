extends "../cNoveaRobot/cNoveaRobot.gd"

var SkillText_1 = "{c_skill}[效率采集]{/c}：【机器采集】的资源获取量提高{c_base}5%{/c}，最多可叠加3次{c_base}(15%){/c}（同类效果取最高）"

func _extInit():
	._extInit()
	chaName = "采集机器人"
	lv = 2
	attCoe.atkRan = 1
	attCoe.maxHp -= 4
	attCoe.atk -= 4
	attCoe.mgiAtk -= 2
	evos = ["cNoveaRobot_1_1", "cNoveaRobot_1_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_1))
