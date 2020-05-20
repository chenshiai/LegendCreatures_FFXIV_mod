extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "赤魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 3.8
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVLarafel_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Verthunder", 8)
	addSkillTxt("""[魔元平衡/连续咏唱]：被动，[赤闪雷]获得15黑魔元，[赤疾风]获得15白魔元，上限100；魔法技能会连续释放两次""")
	addSkillTxt("""[赤闪雷/赤疾风]：复唱时间8s，随机释放其中一个技能对目标造成魔法伤害，威力：120
[魔连攻]：被动，攻击时，同时消耗25点黑白魔元，使物理攻击伤害提高500%""")

const MORGEN = 15 # 释放魔法获得魔元数量
const MORGEN_MAX = 100 # 魔元上限
const VERTHUNDER_PW = 1.20 # 魔法威力
const REDOUBLEMENT_PW = 5 # 魔连攻威力

var blackMorgen = 0 # 黑魔元
var whiteMorgan = 0 # 白魔元

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	blackMorgen = 0 # 黑魔元
	whiteMorgan = 0 # 白魔元

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder" && aiCha != null: verthunder(true)

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL && blackMorgen >= 25 && whiteMorgan >= 25:
		atkInfo.hurtVal *= REDOUBLEMENT_PW
		atkInfo.isCri = true
		blackMorgen -= 25
		whiteMorgan -= 25

# 赤闪雷/赤疾风
func verthunder(first):
	var d:Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(aiCha)
	yield(d,"onReach")
	hurtChara(aiCha, att.mgiAtk * VERTHUNDER_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

	var n = sys.rndRan(0, 1)
	if n == 0 && blackMorgen < 100:
		blackMorgen += MORGEN
		if blackMorgen > 100: blackMorgen = 100
	if n == 1 && whiteMorgan < 100:
		whiteMorgan += MORGEN
		if whiteMorgan > 100: whiteMorgan = 100

	if first:
		yield(reTimer(0.5), "timeout")
		verthunder(false)