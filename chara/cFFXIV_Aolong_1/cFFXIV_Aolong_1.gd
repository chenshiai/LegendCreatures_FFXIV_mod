extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "暗黑骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addSkillTxt("""[深恶痛绝]：被动，战斗开始时，魔法防御提高20%，受到的伤害减少15%
	[嗜血]：被动，攻击恢复自身2%的HP""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理
func _onBattleStart():
	._onBattleStart()
	addBuff(b_Abhor.new(1, true))

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	plusHp(att.maxHp * 0.02)

class b_Abhor:
	extends Buff
	func _init(dur = 1, forever = false):
		._init()
		attInit()
		id = "b_Abhor"
		isNegetive = false
		life = dur
		forever = forever

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func _upS():
		att.mgiDefL = 0.20
		if !forever:
			eff.amount = clamp(life, 1, 30)

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.85
