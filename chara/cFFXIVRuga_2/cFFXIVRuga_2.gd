extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "武僧"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.def = 3.1
	attCoe.mgiDef = 3.1
	attAdd.spd += 0.16
	lv = 2
	evos = ["cFFXIVRuga_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_FightGas", 12)
	addSkillTxt("[迅雷疾风]：被动，增加16%的攻击速度，且在攻击时，获得2层[急速]")
	addSkillTxt("""[斗气]：被动，每攻击有50%概率获得1点斗气，最大5点，满5点后会立即释放[阴阳斗气斩]，不计入冷却时间
[阴阳斗气斩]：ÇÐ12s，对目标造成[210%]的物理伤害，消耗斗气提高伤害，每点斗气提高[20%]的倍率，最大[310%]""")

var fightGas = 0
const FIGHTGAS_PW = 2.10 # 斗气斩威力
const FIGHTGAS_N_PW = 0.20 # 斗气提升威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	fightGas = 0

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		addBuff(b_jiSu.new(2))
		if sys.rndPer(50) && fightGas < 5:
			fightGasUp()

func fightGasUp():
	fightGas += 1
	if fightGas >= 5:
		fightGasAtk()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FightGas":
		fightGasAtk()

func fightGasAtk():
	if aiCha != null:
		hurtChara(aiCha, att.atk * (FIGHTGAS_PW + FIGHTGAS_N_PW * fightGas), Chara.HurtType.PHY, Chara.AtkType.SKILL)
		fightGas = 0