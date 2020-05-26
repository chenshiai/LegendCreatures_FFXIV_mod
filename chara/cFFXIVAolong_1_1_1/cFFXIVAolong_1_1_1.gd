extends "../cFFXIVAolong_1_1/cFFXIVAolong_1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "希德勒格-传奇"
	attCoe.maxHp = 7
	attCoe.atk = 4.5
	attCoe.def = 5.9
	attCoe.mgiDef = 6.5
	lv = 4
	evos = []
	addSkillTxt("""[掠影示现]：被动，令英雄的掠影变为实体与自身并肩作战，与本体同步攻击，造成本体的[30%]的伤害
[行尸走肉]：当受到致命攻击时，不会立即死亡（除特定攻击外），持续10s，一场战斗最多使用一次""")

var baseId = ""
var livingDead = false # 行尸走肉是否触发
var deadTime = 10 # 行尸走肉倒计时

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	livingDead = false
	deadTime = 10

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType != AtkType.EFF:
		atkInfo.hurtVal *= 1.30

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
		deadTime -= 1
