extends "../cFFXIVHumen_2/cFFXIVHumen_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "守约之刃"
	lv = 3
	attAdd.spd += 0.2
	evos = []
	addSkillTxt("""[超火流星]：被动，生命值低于10%时，有概率触发。生命值降为1点，15s内免疫任何伤害，最多触发一次
[续剑]：被动，攻击速度提高20%
[血壤]：被动，普通攻击会附加20%攻击力的魔法伤害""")

func _connect():
	._connect() #保留继承的处理

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if att.Hp <= att.maxHp * 0.10 && sys.rndPer(50):
		addBuff(b_Superbolide.new(15))
		att.Hp = 1

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		hurtChara(atkInfo.hitCha, att.atk * 0.2, Chara.HurtType.MGI, Chara.AtkType.NORMAL)

class b_Superbolide:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Superbolide"
		isNegetive = false
		life = dur

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 15)
		if life <= 1: life = 0