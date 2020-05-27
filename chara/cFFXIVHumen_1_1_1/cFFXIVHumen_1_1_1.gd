extends "../cFFXIVHumen_1_1/cFFXIVHumen_1_1.gd"

func _info():
	pass

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
	addSkillTxt("[地毁人亡]：冷却时间12s，对周围2格内的敌人造成[180%]的物理伤害")
	addSkillTxt("[死斗]：当受到致命伤害时，不会立即死亡（除特定攻击外），持续7s，效果结束后恢复20%的HP")

var baseId = ""
const DECIMATE_PW = 1.80 # 地毁人亡威力
var livingDead = false # 死斗是否触发
var deadTime = 7 # 死斗倒计时

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Decimate":
		var chas = getCellChas(cell,1)
		for i in chas:
			if i != null:
				hurtChara(i, att.atk * DECIMATE_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	if att.hp <= atkInfo.hurtVal:
		if !livingDead:
			atkInfo.hurtVal = 0
			livingDead = true
		elif livingDead && deadTime > 0:
			atkInfo.hurtVal = 0

func _upS():
	._upS()
	if livingDead && deadTime > 0:
		att.hp = 1
		deadTime -= 1
	elif deadTime <= 0:
		plusHp(att.maxHp * 0.20)