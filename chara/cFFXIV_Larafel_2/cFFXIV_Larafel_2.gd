extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "黑魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dang"
	addCdSkill("skill_FireIII", 25)#添加cd技能
	addCdSkill("skill_Freeze", 6)#添加cd技能
	addSkillTxt("""[星极火]：被动，火系魔法释放一次后伤害提升一个档次，每次提升30%的伤害，延长冰系魔法的复唱时间
[灵极冰]：被动，使用冰系魔法后降低三次火系魔法的复唱时间，但会重置火系魔法的伤害提升档次
[爆炎]：复唱时间25s，对目标发动火属性魔法攻击，威力：240
[玄冰]：复唱时间6s，对目标发动冰属性范围魔法攻击，威力：100""")

var fire = 0 # 星极火当前阶段
var freeze = 0 # 灵极冰当前层数
const FIRE_PW = 0.30 # 星极火倍率
const FREEZE_MAX = 3 # 灵极冰最大值
const FIRE_CD = 21 # 每次减火系魔法的cd值
const FIREIII_PW = 2.40 # 爆炎威力
const FREEZE_PW = 1.00 # 玄冰威力

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	fire = 0
	freeze = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FireIII" && aiCha != null:
		fireIII(aiCha)
	if id == "skill_Freeze" && aiCha != null:
		freezeIII(aiCha)
	
func fireIII(aiCha):
	var eff:Eff = newEff("sk_yunShi")
	eff.position = aiCha.position
	eff.scale *= 1.2
	yield(reTimer(0.45),"timeout")

	hurtChara(aiCha, att.mgiAtk * (FIREIII_PW + FIRE_PW * fire), HurtType.MGI)

	fire += 1
	if freeze > 0:
		freeze -= 1
		var sk = getSkill("skill_FireIII")
		var fz = getSkill("skill_Freeze")
		sk.nowTime = FIRE_CD
		fz.nowTime = 0

func freezeIII(aiCha):
	fire = 0
	freeze = FREEZE_MAX
	var sk = getSkill("skill_FireIII")
	sk.nowTime = FIRE_CD
	
	var cell = aiCha.cell
	var chas = getCellChas(cell, 1)

	for i in range(4):
		var eff:Eff = newEff("sk_bingYu")
		eff.position = aiCha.position
	
	yield(reTimer(0.5),"timeout")
	for i in chas:
		if i != null: 
			hurtChara(i, att.mgiAtk * FREEZE_PW, HurtType.MGI)