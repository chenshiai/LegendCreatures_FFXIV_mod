extends "../../2098858773/BossChara.gd"

var limitCutting_pw = 1 # 极限切割威力
var waves_pw = 1 # 冲击威力

var SKILL_TXT = """{c_base}亚历山大绝境战 第二阶段

[极限切割]：出现在随机一个敌人身边，对其所在位置进行范围斩击，造成[{1}]的物理伤害，并附加[易伤]，持续4s{/c}"""

var pwConfig = {
	"1": "未知",
}

func _extInit():
	._extInit()
	chaName = "残暴正义号"
	lv = 4
	attCoe.atkRan = 2
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	
func _init():
	._init()
	STAGE = "p1"
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	# set_time_axis({
	# 	"startP2": [34]
	# })
	closeReward()
	FFControl.HpBar.show()
	FFControl.FFMusic.play(Path, "/music/機工城律動編.oggstr")
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	sys.main.btChas.append(self)
	self.visible = false

func _onBattleStart():
	._onBattleStart()
	STAGE = "p2"
	closeReward()
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 190
	limitCutting_pw *= (E_lv / E_num) # 流体震荡威力
	waves_pw *= (E_lv / E_num)
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))
	cell = Vector2(4, 2)
	position = sys.main.map.map_to_world(Vector2(4, 2))
	self.visible = true
	Utils.draw_shadow(img, position + Vector2(0, -400), position, 25)
	Utils.background_change(Path, "/background/TheEpicOfAlexander2.png")
	Utils.draw_effect("bombardment", position, Vector2(0, -50), 6, 6)
	complexHurt(getAllChas(1), att.atk * limitCutting_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
