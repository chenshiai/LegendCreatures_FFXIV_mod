extends "../cFFXIVBossTheEpicofAlexander_Hide/BossChara.gd"
const BERSERKERTIME_P1 = 120 # P1狂暴时间

var fluidOscillation_pw = 4 # 流体震荡威力
var pourOut_pw = 0.8 # 倾泻威力
var waves_pw = 1 # 万变水波威力

var SKILL_TXT = """{c_base}亚历山大绝境战 第一阶段

[流体震荡]：{TDeath}对当前目标造成{c_mgi}[{1}]{/c}的小范围魔法伤害。
[倾泻]：对全屏的敌人造成{c_mgi}[{2}]{/c}的水属性魔法伤害。
[活水之手]：当生命值低于一半时会分化出一个[活水之手]。
[万变水波]：射出水波，造成{c_mgi}[{3}]{/c}的水属性魔法伤害，并附加[水耐性下降·中]，之后会生成一个水球。
[痛苦之手]：对全屏敌人造成水属性的魔法伤害，根据[活水之手]与[有生命活水]生命差值正比提高伤害。{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
}

func _extInit():
	._extInit()
	chaName = "有生命活水"
	lv = 4
	attCoe.atkRan = 1
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt(TEXT.BOSS_LIVING_LIQUID)
	
func _init():
	._init()
	reward = false
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		# "pourOut": [20, 60, 100, 140, 340],
		"waves": [2, 12, 22, 32, 42, 52, 62],
		# "fluidOscillation": [33, 73, 113, 153, 360]
	})
	Utils.background_change(Path, "/background/TheEpicOfAlexander.png")
	FFControl.FFMusic.play(Path, "/music/dregs.oggstr")
	
func _onBattleStart():
	._onBattleStart()
	attInfo.maxHp = (E_atk + E_mgiAtk) / E_num * layer * 3
	fluidOscillation_pw *= (E_lv / E_num) # 流体震荡威力
	pourOut_pw *= (E_lv / E_num) # 倾泻威力
	waves_pw *= (E_lv / E_num) # 水波威力
	pwConfig = {
		"1": "%d%%" % [fluidOscillation_pw * 100],
		"2": "%d%%" % [pourOut_pw * 100],
		"3": "%d%%" % [waves_pw * 100],
	}
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))

func fluidOscillation():
	self.HateTarget = aiCha
	Chant.chantStart("流体震荡", 5)
	yield(reTimer(5), "timeout")
	var chas = getCellChas(self.HateTarget.cell, 1)
	Utils.draw_effect("blastYellow", self.HateTarget.position, Vector2(0, -50), 15)
	if att.hp <= 0:
		return
	for i in chas:
		if i != self:
			FFHurtChara(i, att.mgiAtk * fluidOscillation_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func pourOut():
	Chant.chantStart("倾泻", 4)
	yield(reTimer(4), "timeout")
	var chas = getAllChas(1)
	Utils.draw_effect("energyStorage", Vector2(350, 0), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.draw_effect("energyStorage", Vector2(150, 150), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.draw_effect("energyStorage", Vector2(500, 200), Vector2(0, 0), 13, 6)

	if att.hp <= 0:
		return
	for i in chas:
		if i != null:
			FFHurtChara(i, att.mgiAtk * pourOut_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func waves():
	aiOn = false
	Chant.chantStart("万变水波", 5)
	yield(reTimer(5), "timeout")
	if att.hp <= 0:
		return
	var chas = getAllChas(1)
	for cha in chas:
		if cha != null:
			var rotation = atan2(cha.position.y - position.y, cha.position.x - position.x)
			var eff = Utils.draw_effect(
				"mopao",
				self.position + Vector2(0, -35),
				Vector2(-125, 0), 21, 3,
				false,
				rotation
			)
			eff.z_index = 0
			var chas2 = Utils.lineChas(cell, cha.cell, 15)
			for cha in chas2:
				if cha.team != team :
					FFHurtChara(cha, att.atk * waves_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	yield(reTimer(2), "timeout")
	aiOn = true
	