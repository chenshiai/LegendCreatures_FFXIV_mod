extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

var fightGas = 0
const FIGHTGAS_PW = 2.10 # 斗气斩威力
const FIGHTGAS_N_PW = 0.20 # 斗气提升威力

func _extInit():
	._extInit()
	OCCUPATION = "CloseCombat"
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 4
	attCoe.def = 3.1
	attCoe.mgiDef = 3.1
	attAdd.spd += 0.16
	lv = 2
	evos = ["cFFXIVRuga_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_FightGas", 10)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleStart():
	._onBattleStart()
	fightGas = 0


func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		addBuff(b_jiSu.new(2))
		if sys.rndPer(35) and fightGas < 5:
			fightGasUp()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FightGas":
		fightGasAtk()


func fightGasUp():
	fightGas += 1
	Utils.draw_efftext("斗气", position, "#ff6631")
	if fightGas >= 5:
		fightGasAtk()


func fightGasAtk():
	FFHurtChara(aiCha, att.atk * (FIGHTGAS_PW + FIGHTGAS_N_PW * fightGas), PHY, SKILL)
	fightGas = 0