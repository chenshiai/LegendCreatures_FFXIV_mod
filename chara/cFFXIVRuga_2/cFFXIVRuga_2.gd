extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
var Utils = globalData.infoDs["g_FFXIVUtils"]

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "武僧"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 1
	attCoe.def = 3.1
	attCoe.mgiDef = 3.1
	attAdd.spd += 0.18
	lv = 2
	evos = ["cFFXIVRuga_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_FightGas", 7)
	addSkillTxt("[迅雷疾风]：被动，增加16%的攻击速度，且在攻击时，获得2层[急速]")
	addSkillTxt("""[斗气]：被动，每次攻击有50%概率获得一层斗气，最大五层
[阴阳斗气斩]：冷却时间7s，对目标造成[210%]的物理伤害，根据斗气层数提高伤害，每层提高[20%]的倍率，最大伤害[310%]""")

#进入战斗初始化，事件连接在这里初始化
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
			fightGas += 1

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FightGas":
		fightGasAtk()

func fightGasAtk():
	if aiCha != null:
		hurtChara(aiCha, att.atk * (FIGHTGAS_PW + FIGHTGAS_N_PW * fightGas), Chara.HurtType.PHY, Chara.AtkType.SKILL)
		fightGas = 0