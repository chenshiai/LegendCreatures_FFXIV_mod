extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _extInit():
	._extInit()
	OCCUPATION = "MagicDPS"
	chaName = "黑魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4.2
	attCoe.def = 2.8
	attCoe.mgiDef = 3.3
	lv = 2
	evos = ["cFFXIVLarafel_2_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_FireIII", 26)
	addCdSkill("skill_Freeze", 4)
	addSkillTxt(TEXT.format("""[星极火]：『{TPassive}』[爆炎]释放后，后续的[爆炎]伤害增加30%，延长[玄冰]的冷却
[灵极冰]：『{TPassive}』使用[玄冰]后降低[爆炎]的冷却三次，重置[爆炎]的伤害提升阶段"""))
	addSkillTxt(TEXT.format("""[爆炎]：冷却26s，对目标造成[240%]的{TMgiHurt}
[玄冰]：冷却4s，对目标及周围一格的敌人造成[100%]的{TMgiHurt}"""))

const FIRE_PW = 0.30 # 星极火倍率
const FREEZE_MAX = 3 # 灵极冰最大值
const FIRE_CD = 23 # 每次减火系魔法的cd值
const FIREIII_PW = 2.40 # 爆炎威力
const FREEZE_PW = 1.00 # 玄冰威力
var handleSkillFire = null # 获取当前爆炎技能
var handleSkillFreeze = null # 获取当前玄冰技能
var fire = 0 # 星极火当前阶段
var freeze = 0 # 灵极冰当前层数

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	handleSkillFire = getSkill("skill_FireIII")
	handleSkillFreeze = getSkill("skill_Freeze")
	fire = 0
	freeze = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FireIII":
		fireIII()
	if id == "skill_Freeze":
		freezeIII()

# 火三
func fireIII():
	Utils.createEffect("fireIII", aiCha.position, Vector2(0, -50), 15)
	yield(reTimer(0.5), "timeout")
	FFHurtChara(aiCha, att.mgiAtk * (FIREIII_PW + FIRE_PW * fire), Chara.HurtType.MGI, Chara.AtkType.SKILL)
	enhanced()

# 消耗灵极心，提高火阶段，减少火3cd，重置冰cd
func enhanced():
	handleSkillFreeze.nowTime = 0
	fire += 1
	if freeze > 0:
		freeze -= 1
		handleSkillFire.nowTime = FIRE_CD

# 冰三		
func freezeIII():
	for i in range(4):
		var eff:Eff = newEff("sk_bingYu")
		eff.position = aiCha.position

	fire = 0
	freeze = FREEZE_MAX
	handleSkillFire.nowTime = FIRE_CD

	var cell = aiCha.cell
	var chas = getCellChas(cell, 1)
	for i in chas:
		FFHurtChara(i, att.mgiAtk * FREEZE_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)