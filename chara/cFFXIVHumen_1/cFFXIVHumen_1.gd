extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4.7
	attCoe.atk = 4
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 2
	evos = ["cFFXIVHumen_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Shiver", 20)
	addSkillTxt("[守护]：受到的伤害减少20%")
	addSkillTxt("[战栗]：冷却20s，立即治疗20%的最大生命值。然后最大生命值提高20%，受到的治疗量提高20%，持续20s")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Shiver":
		shiver()

func _onBattleStart():
	._onBattleStart()

func shiver():
	plusHp(att.maxHp * 0.20)
	BUFF_LIST.b_Shiver.new(20, self)
	var eff = newEff("numHit", Vector2(30, -60))
	eff.setText("战栗！", "#3cff00")

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80