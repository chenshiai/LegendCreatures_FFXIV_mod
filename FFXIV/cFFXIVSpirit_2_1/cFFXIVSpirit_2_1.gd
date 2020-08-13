extends "../cFFXIVSpirit_2/cFFXIVSpirit_2.gd"

const LORDOFCROWNS_PW = 1
const LADYOFCROWNS_PW = 1

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard":
		yield(reTimer(0.5), "timeout")
		if sys.rndPer(50):
			var chas = getAllChas(2)
			chas.sort_custom(Utils.Calculation, "sort_MinHpP")

			if chas[0] != null:
				chas[0].plusHp(att.mgiAtk * LADYOFCROWNS_PW)
				Utils.draw_efftext("王冠之贵妇", chas[0].position, "#ffffff")
		else:
			var d:Eff = newEff("sk_feiDang",sprcPos)
			d._initFlyCha(aiCha)
			Utils.draw_efftext("王冠之领主", position, "#ffffff")
			yield(d, "onReach")
			FFHurtChara(aiCha, att.mgiAtk * LORDOFCROWNS_PW, MGI, SKILL)
