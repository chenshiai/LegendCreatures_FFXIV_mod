extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述

func _extInit():
	._extInit()#保留继承的处理
	chaName = "骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3.5
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVRuga_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Grace", 10)#添加cd技能
	addSkillTxt("""[钢铁信念]：被动，战斗开始后，提高10%的物理防御，受到的伤害减少10%
[深仁厚泽]：复唱时间10s，为生命最低的单位恢复生命值。威力：100""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	addBuff(b_SteelBelief.new(10))

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Grace":
		var cha = null
		var m = 10000
		var chas = getAllChas(2)
		for i in chas:
			if i.att.hp / i.att.maxHp < m :
				cha = i
				m = i.att.hp / i.att.maxHp
		if cha != null: cha.plusHp(att.mgiAtk * 1)

class b_SteelBelief:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_SteelBelief"
		isNegetive = false
		life = dur

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func _upS():
		att.defL = 0.10
		life = clamp(life, 0, 10)
		if life <= 1: life = 10

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90