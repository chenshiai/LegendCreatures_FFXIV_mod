extends "../BaseChara/FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const MORGEN = 15 # 释放魔法获得魔元数量
const MORGEN_MAX = 100 # 魔元上限
const VERTHUNDER_PW = 1.20 # 魔法威力
const REDOUBLEMENT_PW = 5 # 魔连攻威力
const REDOUBLEMENT_CAST = 25 # 魔连攻消耗魔元值
const VERFLARE_PW = 2.30 # 赤核爆威力

var blackMorgen = 0 # 黑魔元
var whiteMorgan = 0 # 白魔元

func _init():
	logoImgName = "RedMage"

func _extInit():
	._extInit()
	OCCUPATION = "Magic"
	chaName = FFData.name_1
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4.2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVLarafel_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Verthunder", 8)
	addSkillTxt(FFData.meterage % [0, 0])
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleEnd():
	._onBattleEnd()
	blackMorgen = 0 # 黑魔元
	whiteMorgan = 0 # 白魔元
	updateMorgen()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder" and aiCha != null:
		verthunder(true, VERTHUNDER_PW)


func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if (atkInfo.atkType == NORMAL
			and blackMorgen >= REDOUBLEMENT_CAST
			and whiteMorgan >= REDOUBLEMENT_CAST):
		atkInfo.hurtVal *= REDOUBLEMENT_PW
		atkInfo.isCri = true
		blackMorgen -= REDOUBLEMENT_CAST
		whiteMorgan -= REDOUBLEMENT_CAST
		if self.lv >= 3:
			verthunder(false, VERFLARE_PW)


func updateMorgen():
	skillStrs[0] = FFData.meterage % [whiteMorgan, blackMorgen]


func morgenLimit():
	if whiteMorgan > MORGEN_MAX:
		whiteMorgan = MORGEN_MAX
	if blackMorgen > MORGEN_MAX:
		blackMorgen = MORGEN_MAX


# 赤闪雷/赤疾风
func verthunder(first, pw):
	var d:Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(aiCha, 1000)
	yield(d, "onReach")
	FFHurtChara(aiCha, att.mgiAtk * pw, MGI, SKILL)

	var n = sys.rndRan(0, 1)
	if n == 0 and blackMorgen < (MORGEN + MORGEN_MAX):
		blackMorgen += MORGEN
	elif n == 1 and whiteMorgan < (MORGEN + MORGEN_MAX):
		whiteMorgan += MORGEN

	morgenLimit()
	updateMorgen()
	if first:
		verthunder(false, VERTHUNDER_PW)