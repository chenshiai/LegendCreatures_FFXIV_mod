extends "../../2098858773/BossChara.gd"

var SKILL_TXT = """{c_base}亚历山大绝境战 第三阶段

{c_skill}[时间停止]]{/c}："""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知"
}


func _extInit():
	._extInit()
	chaName = "至尊亚历山大"
	lv = 4
	attCoe.atkRan = 2
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))

func _init():
	._init()
	sys.main.btChas.append(self)
	STAGE = "p1"
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	# set_time_axis({
	# 	"fluidOscillation": [29, 43, 66, 96, 122],
	# 	"steamWarShip": [17, 36, 53, 77, 90, 114, 129],
	# 	"flaming": [82, 104]
	# })
	closeReward()
	FFControl.HpBar.show()
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	self.connect("onHurtEnd", FFControl.HpBar, "hpDown")
	self.scale *= 1.3
	self.show_on_top = false


func _onBattleStart():
	._onBattleStart()
	self.visible = false
	aiOn = false
	STAGE = "p1"
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 430
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))

	cell = Vector2(4, 0)
	position = sys.main.map.map_to_world(Vector2(4, 0))
	Utils.draw_effect_v2({
		"name": "changeStage",
		"pos": Vector2(350, 150),
		"fps": 6,
	})
	yield(reTimer(1), "timeout")
	Utils.background_change(Path, "/background/TheEpicOfAlexander3.png")
	self.visible = true
	self.isDeath = true
	sonicBoom()

func sonicBoom():
	Chant.chantStart("时间停止", 4)
	yield(reTimer(4), "timeout")
	FFControl.FFMusic.play(Path, "/music/無限停止.oggstr")
	yield(reTimer(14), "timeout")
	self.isDeath = false
	aiOn = true
	FFControl.FFMusic.play(Path, "/music/機工城天動編.oggstr")
