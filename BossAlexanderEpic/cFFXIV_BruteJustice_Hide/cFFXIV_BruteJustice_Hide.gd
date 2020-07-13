extends "../../2098858773/BossChara.gd"

var justiceKicks_pw = 1 # 正义飞踢威力

var SKILL_TXT = """{c_base}亚历山大绝境战 第二阶段

{c_skill}[正义飞踢]{/c}：残暴正义号闪亮登场！对所有敌人造成{c_phy}[{1}]{/c}的物理伤害{/c}"""

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
	justiceKicks_pw *= (E_lv / E_num) # 正义飞踢威力
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))
	justiceKicks()

func justiceKicks():
	cell = Vector2(4, 2)
	position = sys.main.map.map_to_world(Vector2(4, 2))
	self.visible = true
	Utils.draw_shadow(img, position + Vector2(0, -400), position, 25)
	Utils.background_change(Path, "/background/TheEpicOfAlexander2.png")
	Utils.draw_effect("bombardment", position, Vector2(0, -50), 6, 6)
	complexHurt(getAllChas(1), att.atk * justiceKicks_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
