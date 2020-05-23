extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4.3
	attCoe.atk = 3.7
	attCoe.mgiAtk = 0.5
	attCoe.def = 5
	attCoe.mgiDef = 4
	lv = 2
	evos = ["cFFXIVRuga_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Grace", 15)
	addCdSkill("skill_Authority", 10)
	addSkillTxt("[钢铁信念]：被动，战斗开始后，提高10%的物理防御，受到的伤害减少10%")
	addSkillTxt("""[深仁厚泽]：冷却时间15s，为生命最低的单位使用治疗魔法，恢复[1200%]法强的生命值
[王权剑]：冷却时间10s，对目标造成[350%]的物理伤害""")

const GRACE_PW = 12 # 深仁厚泽威力
const AUTHORITY_PW = 3.50 # 王权剑威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	addBuff(b_SteelBelief.new())

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Grace": grace()
	if id == "skill_Authority": authority()

# 深仁厚泽		
func grace():
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null: cha.plusHp(att.mgiAtk * GRACE_PW, true)

# 王权剑		
func authority():
	if aiCha != null:
		hurtChara(aiCha, att.atk * AUTHORITY_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

class b_SteelBelief:
	extends Buff
	func _init():
		attInit()
		id = "b_SteelBelief"
		isNegetive = false
		att.defL = 0.10

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90