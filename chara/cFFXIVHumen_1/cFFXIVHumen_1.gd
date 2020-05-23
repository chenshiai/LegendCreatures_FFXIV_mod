extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4.6
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 2
	evos = ["cFFXIVHumen_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Shiver", 20)
	addSkillTxt("[守护]：受到的伤害减少20%")
	addSkillTxt("[战栗]：冷却时间20s，立即治疗20%的最大生命值。然后最大生命值提高20%，受到的治疗量提高20%，持续10s")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Shiver": shiver()

func _onBattleStart():
	._onBattleStart()

func shiver():
	plusHp(att.maxHp * 0.20, true)
	addBuff(b_Shiver.new(10))
	var eff = newEff("numHit", Vector2(30, -60))
	eff.setText("战栗！", "#3cff00")

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
		att.maxHpL = 0.20
		att.reHp = 0.20

	func _upS():
		life = clamp(life, 0, 10)
		if life <= 1: life = 0