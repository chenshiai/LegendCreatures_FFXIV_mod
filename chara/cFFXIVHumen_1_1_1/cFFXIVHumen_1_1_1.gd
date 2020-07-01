extends "../cFFXIVHumen_1_1/cFFXIVHumen_1_1.gd"

const DECIMATE_PW = 1.80 # 地毁人亡威力
var livingDead = false # 死斗是否触发
var deadTime = 7 # 死斗倒计时


func _extInit():
	._extInit()
	chaName = "阿尔伯特-传奇"
	attCoe.maxHp = 6.5
	attCoe.atk = 4.8
	attCoe.def = 5.5
	attCoe.mgiDef = 5.5
	lv = 4
	evos = []
	addCdSkill("skill_Decimate", 12)
	addSkillTxt(TEXT.format("[地毁人亡]：冷却12s，对周围2格内的敌人造成[180%]的{TPhyHurt}"))
	addSkillTxt("[死斗]：濒死时开启，不会死亡(除特定攻击外)，持续7s，然后恢复20%的生命值，最多触发一次")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	livingDead = false
	deadTime = 7

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Decimate":
		var chas = getCellChas(cell, 2)
		for i in chas:
			FFHurtChara(i, att.atk * DECIMATE_PW, PHY, SKILL)

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	if att.hp <= atkInfo.hurtVal:
		if !livingDead:
			atkInfo.hurtVal = 0
			livingDead = true
		elif livingDead and deadTime >= 0:
			atkInfo.hurtVal = 0

func _upS():
	._upS()
	if livingDead and deadTime > 0:
		att.hp = 1
		deadTime -= 1
	elif deadTime == 0:
		plusHp(att.maxHp * 0.20)
		deadTime -= 1