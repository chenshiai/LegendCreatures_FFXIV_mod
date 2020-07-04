extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

const TRICKATTACK_PW = 3.0 # 攻其不备威力
const FUMA_PW = 5.0 # 风魔手里剑威力
const RAITON_PW = 4.80 # 雷遁威力
const HYOTON_PW = 1.50 # 冰遁威力
const KATON_PW = 1.50 # 火遁威力
var Assassinate = false # 是否为生杀予夺状态
var colorConfig = {
	"ten": "[color=#7ed9ff]『天』[/color]", # 0
	"chi": "[color=#ffae57]『地』[/color]", # 1
	"jin": "[color=#fdff57]『人』[/color]" # 2
}
var SKILL_TXT_1 = TEXT.format("""[隐遁]：{TPassive}获得30%的闪避，移动速度提高50
[攻其不备]：冷却15s，对目标造成[300%]的{TPhyHurt}，并目标受到的任何伤害增加20%，持续10s{c_base}
[忍术]：冷却11s，从{ten}/{chi}/{jin}中连续结出两个手印，并根据结印顺序释放以下忍术
[风魔手里剑]：两个相同手印，对魔法强度最高的一名敌人造成{c_phy}[500%]{/c}的{TPhyHurt}
[火遁之术]：{chi}{ten}/{jin}{ten}对目标及周围2格的敌人造成{c_phy}[150%]{/c}的{TMgiHurt}，并附加5层[烧灼]
[雷遁之术]：{ten}{chi}/{jin}{chi}对目标造成{c_phy}[480%]{/c}的{TMgiHurt}
[冰遁之术]：{ten}{jin}/{chi}{jin}对目标及周围2格的敌人造成{c_phy}[150%]{/c}的{TMgiHurt}，并附加5层[结霜]{/c}""", colorConfig)

func _extInit():
	._extInit()
	OCCUPATION = "MeleeDPS"
	chaName = "忍者"
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 4.1
	attCoe.def = 2.8
	attCoe.mgiDef = 3
	attAdd.dod += 0.30
	moveSpeed += 50
	lv = 2
	evos = ["cFFXIVAolong_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_TrickAttack", 15)
	addCdSkill("skill_Ninjutsu", 11)
	addSkillTxt(SKILL_TXT_1)


func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	Assassinate = false

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_TrickAttack":
		trickAttack()
	if id == "skill_Ninjutsu":
		ninjutsu()
		# Utils.draw_effect("whirlwind", Vector2(position.x, position.y - 1), Vector2(0,-40), 15, 1, false)

func trickAttack():
	FFHurtChara(aiCha, att.atk * TRICKATTACK_PW, PHY, SKILL)
	BUFF_LIST.b_TrickAttack.new({
		"cha": aiCha,
		"dur": 10
	})

func ninjutsu():
	var Mudra = [] # 结印数组
	for i in range(2):
		var n = sys.rndRan(0, 2)
		match n:
			0: 
				Utils.draw_efftext("天", position, "#7ed9ff")
			1:
				Utils.draw_efftext("地", position, "#ffae57")
			2:
				Utils.draw_efftext("人", position, "#fdff57")
		Mudra.push_back(n)
		yield(reTimer(0.5), "timeout")

	if att.hp <= 0:
		return

	if Mudra[0] == Mudra[1]:
		fuma()
		return
	
	match Mudra[1]:
		0: katon()
		1: raiton()
		2: hyoton()

# 风魔手里剑
func fuma():
	var chas = getAllChas(1)
	chas.sort_custom(Utils.Calculation, "sort_MaxMgiAtk")

	var d:Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(chas[0])
	Utils.draw_efftext("风魔", position)
	yield(d, "onReach")
	FFHurtChara(chas[0], att.atk * FUMA_PW, PHY, SKILL)

# 雷遁之术
func raiton():
	Utils.draw_efftext("雷遁", position)
	FFHurtChara(aiCha, att.atk * RAITON_PW, MGI, SKILL)

# 冰遁之术
func hyoton():
	if Assassinate:
		Assassinate = false
		Utils.draw_efftext("冰晶乱流", position)
		FFHurtChara(aiCha, att.atk * 12, MGI, SKILL)
	else:
		Utils.draw_efftext("冰遁", position)
		var chas = getCellChas(aiCha.cell, 2, 1)
		for i in chas:
			FFHurtChara(i, att.atk * HYOTON_PW, MGI, SKILL)
			i.addBuff(b_jieShuang.new(5))

# 火遁之术			
func katon():
	if Assassinate:
		Assassinate = false
		Utils.draw_efftext("劫火灭却", position)
		var chas = getCellChas(aiCha.cell, 2, 1)
		for i in chas:
			FFHurtChara(i, att.atk * 7, MGI, SKILL)
	else:
		Utils.draw_efftext("火遁", position)
		var chas = getCellChas(aiCha.cell, 2, 1)
		for i in chas:
			FFHurtChara(i, att.atk * KATON_PW, MGI, SKILL)
			i.addBuff(b_shaoZhuo.new(5))
