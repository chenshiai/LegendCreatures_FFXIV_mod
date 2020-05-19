extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_Shiver", 20)
	addSkillTxt("""[守护]：受到的伤害减少20%
[战栗]：复唱时间20s，治疗20%的最大生命值。最大生命值提高20%，受到的治疗量提高20%，持续10s""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Shiver":
		plusHp(att.maxHp * 0.20)
		addBuff(b_Shiver.new(10))

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80

class b_Shiver:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Shiver"
		isNegetive = false
		life = dur

	func _upS():
		att.maxHpL = 0.20
		att.reHp = 0.20
		life = clamp(life, 0, 10)
		if life <= 1: life = 0