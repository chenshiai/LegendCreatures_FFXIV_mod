extends "../cFFXIVAolong_1/cFFXIVAolong_1.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "深渊之暗"
	lv = 3
	evos = []
	addCdSkill("skill_DarkMissionary", 12)
	addSkillTxt("""[至黑之夜]：被攻击时,累积10%攻击伤害的暗黑值，达到100点时，释放可以吸收最大生命值20%的护盾
[暗黑布道]：冷却时间12s，使队伍全员受到魔法伤害减少20%，持续6s""")

var darkCount = 0 # 暗黑值

func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	darkCount = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DarkMissionary": darkMissionary()

func darkMissionary():
	var allys = getAllChas(2)
	for cha in allys:
		if cha != null:
			cha.addBuff(b_DarkMissionary.new(6))

func _onHurt(atkInfo):
	_onHurt(atkInfo)
	darkCount += atkInfo.atkVal * 0.10
	if darkCount >= 100:
		addBuff(b_TheBlackestNight.new(att.maxHp * 0.20))

class b_DarkMissionary:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_DarkMissionary"
		life = dur
		isNegetive = false

		func _connect():
			masCha.connect("onHurt", self, "onHurt")
	
		func onHurt(atkInfo:AtkInfo):
			if atkInfo.hurtType == Chara.HurtType.MGI:
				atkInfo.hurtVal *= 0.80

# 至黑之夜，护盾。可以吸收一定数值的伤害
class b_TheBlackestNight:
	extends Buff
	var total setget set_total, get_total

	func get_total():
		return total
	func set_total(val):
		total = val

	func _init(val = 0):
		attInit()
		id = "b_TheBlackestNight"
		total = val

	func _connect():
		._connect()
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		if total >= 0:
			if total > atkInfo.hurtVal:
				total -= atkInfo.hurtVal
				atkInfo.hurtVal = 0
			else:
				atkInfo.hurtVal -= total
				total = 0
		elif total <= 0:
			total = 0