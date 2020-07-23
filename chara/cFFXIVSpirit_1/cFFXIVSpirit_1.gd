extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const STARPHASE_PW = 0.60 # 阳星威力
const MALEFIC_PW = 0.7 # 煞星威力

func _extInit():
	._extInit()
	OCCUPATION = "Treatment"
	chaName = FFData.name_1
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 2.9
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVSpirit_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_DrawCard", 20)
	addCdSkill("skill_Malefic", 4)
	addCdSkill("skill_StarPhase", 16)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleStart():
	._onBattleStart()
	drawCard()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard" :
		drawCard()
	if id == "skill_StarPhase":
		starPhase(self.lv)
	if id == "skill_Malefic":
		malefic()


func malefic():
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")
	FFHurtChara(aiCha, att.mgiAtk * MALEFIC_PW, MGI, SKILL)


func drawCard():
	var n = sys.rndRan(0, 5)
	var bf = null
	if n == 0:
		Utils.draw_effect("Arcana_01", position, Vector2(0, -240), 14, 0.5)
		bf = "b_Balance"
	elif n == 1:
		Utils.draw_effect("Arcana_02", position, Vector2(0, -240), 14, 0.5)
		bf = "b_Arrow"
	elif n == 2:
		Utils.draw_effect("Arcana_03", position, Vector2(0, -240), 14, 0.5)
		bf = "b_Spear"
	elif n == 3:
		Utils.draw_effect("Arcana_04", position, Vector2(0, -240), 14, 0.5)
		bf = "b_Bole"
	elif n == 4:
		Utils.draw_effect("Arcana_05", position, Vector2(0, -240), 14, 0.5)
		bf = "b_Ewer"
	elif n == 5:
		Utils.draw_effect("Arcana_06", position, Vector2(0, -240), 14, 0.5)
		bf = "b_Spire"

	var chas = getAllChas(2)
	for cha in chas:
		if cha != null and bf != null:
			BUFF_LIST[bf].new({"cha": cha, "dur": 20})


# 阳星相位
func starPhase(lv):
	var allys = getAllChas(2)
	allys.shuffle()
	for cha in allys:
		if cha != null and !cha.isDeath:
			cha.plusHp(att.mgiAtk * STARPHASE_PW)
			BUFF_LIST.b_LuckyStar.new({"cha": cha, "dur": 5, "hot": att.mgiAtk * 0.10})
			if lv == 4:
				BUFF_LIST.b_Night.new({"cha": cha, "dur": 10, "HD": att.mgiAtk * STARPHASE_PW * 1.25})
				Utils.draw_effect("ePcr_mgiPZ", cha.position, Vector2(0,-30), 14)
			yield(reTimer(0.1), "timeout")
