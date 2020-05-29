extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

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
	addSkillTxt("白魔元：%d / 100	黑魔元：%d / 100" % [whiteMorgan, blackMorgen])
	addSkillTxt("""[魔元平衡/连续咏唱]：被动，[赤闪雷]获得15黑魔元，[赤疾风]获得15白魔元，上限100；魔法技能会连续释放两次
[赤闪雷/赤疾风]：冷却时间8s，随机释放其中一个技能对目标造成[110%]法强的魔法伤害
[魔连攻]：被动，攻击时同时消耗25点黑白魔元，使物理攻击伤害提高500%""")

const MORGEN = 15 # 释放魔法获得魔元数量
const MORGEN_MAX = 100 # 魔元上限
const VERTHUNDER_PW = 1.10 # 魔法威力
const REDOUBLEMENT_PW = 5 # 魔连攻威力
const REDOUBLEMENT_CAST = 25 # 魔连攻消耗魔元值
const VERFLARE_PW = 2.20 # 赤核爆威力

var blackMorgen = 0 # 黑魔元
var whiteMorgan = 0 # 白魔元

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onBattleEnd():
	._onBattleEnd()
	blackMorgen = 0 # 黑魔元
	whiteMorgan = 0 # 白魔元

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder" && aiCha != null:
		verthunder(true, VERTHUNDER_PW)

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if (atkInfo.atkType == AtkType.NORMAL
			&& blackMorgen >= REDOUBLEMENT_CAST
			&& whiteMorgan >= REDOUBLEMENT_CAST):
		atkInfo.hurtVal *= REDOUBLEMENT_PW
		atkInfo.isCri = true
		blackMorgen -= REDOUBLEMENT_CAST
		whiteMorgan -= REDOUBLEMENT_CAST
		if lv == 3:
			verthunder(false, VERFLARE_PW)

# 赤闪雷/赤疾风
func verthunder(first, pw):
	var d:Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")
	hurtChara(aiCha, att.mgiAtk * pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

	var n = sys.rndRan(0, 1)
	if n == 0 && blackMorgen < (MORGEN + MORGEN_MAX):
		blackMorgen += MORGEN
		if blackMorgen > MORGEN_MAX:
			blackMorgen = MORGEN_MAX
	elif n == 1 && whiteMorgan < (MORGEN + MORGEN_MAX):
		whiteMorgan += MORGEN
		if whiteMorgan > MORGEN_MAX:
			whiteMorgan = MORGEN_MAX

	if first:
		yield(reTimer(0.3), "timeout")
		verthunder(false, VERTHUNDER_PW)