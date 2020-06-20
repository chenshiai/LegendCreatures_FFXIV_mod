extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	OCCUPATION = "DistanceDPS"
	chaName = "赤魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 3.9
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVLarafel_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Verthunder", 8)
	addSkillTxt("白魔元：0 / 100	黑魔元：0 / 100")
	addSkillTxt(TEXT.format("""[连续咏唱]：{TPassive}攻击型技能会连续释放两次（只触发一次CD效果）
[赤闪雷/赤疾风]：冷却8s，对目标造成[120%]法强的{TMgiHurt}，随机获得[黑/白]魔元15点
[魔连攻]：{TPassive}攻击时同时消耗25点黑白魔元，使此次物理攻击造成[500%]的伤害"""))

const MORGEN = 15 # 释放魔法获得魔元数量
const MORGEN_MAX = 100 # 魔元上限
const VERTHUNDER_PW = 1.20 # 魔法威力
const REDOUBLEMENT_PW = 5 # 魔连攻威力
const REDOUBLEMENT_CAST = 25 # 魔连攻消耗魔元值
const VERFLARE_PW = 2.40 # 赤核爆威力

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
	skillStrs[0] = "白魔元：%d / 100	黑魔元：%d / 100" % [whiteMorgan, blackMorgen]

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder" and aiCha != null:
		verthunder(true, VERTHUNDER_PW)

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if (atkInfo.atkType == AtkType.NORMAL
			and blackMorgen >= REDOUBLEMENT_CAST
			and whiteMorgan >= REDOUBLEMENT_CAST):
		atkInfo.hurtVal *= REDOUBLEMENT_PW
		atkInfo.isCri = true
		blackMorgen -= REDOUBLEMENT_CAST
		whiteMorgan -= REDOUBLEMENT_CAST
		if lv == 3:
			verthunder(false, VERFLARE_PW)

# 赤闪雷/赤疾风
func verthunder(first, pw):
	var d:Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(aiCha, 1000)
	yield(d, "onReach")
	FFHurtChara(aiCha, att.mgiAtk * pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

	var n = sys.rndRan(0, 1)
	if n == 0 and blackMorgen < (MORGEN + MORGEN_MAX):
		blackMorgen += MORGEN
		if blackMorgen > MORGEN_MAX:
			blackMorgen = MORGEN_MAX
	elif n == 1 and whiteMorgan < (MORGEN + MORGEN_MAX):
		whiteMorgan += MORGEN
		if whiteMorgan > MORGEN_MAX:
			whiteMorgan = MORGEN_MAX

	skillStrs[0] = "白魔元：%d / 100	黑魔元：%d / 100" % [whiteMorgan, blackMorgen]
	if first:
		verthunder(false, VERTHUNDER_PW)