extends "../../2098858773/BossChara.gd"

var SKILL_TXT = """{c_base}亚历山大绝境战 第二阶段{/c}"""

func _extInit():
	._extInit()
	chaName = "巡航驱逐者"
	lv = 4
	attCoe.atkRan = 2
	addSkillTxt(TEXT.format(SKILL_TXT))
	
func _init():
	._init()
	set_path("cFFXIV_CruiseChaser_Hide")
	closeReward()
	FFControl.HpBar.show()
	self.connect("onHurtEnd", FFControl.HpBar, "hpDown")
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	sys.main.btChas.append(self)
