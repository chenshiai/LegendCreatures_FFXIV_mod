extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "赤魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_Verthunder", 8)#添加cd技能
	addSkillTxt("""[魔元平衡/连续咏唱]：被动，[赤闪雷]获得15黑魔元，[赤疾风]获得15白魔元，上限100；魔法技能会连续释放两次
[赤闪雷/赤疾风]：复唱时间8s，随机释放其中一个技能对目标造成魔法伤害，威力：110
[魔连攻]：被动，当攻击目标在1格内时，物理攻击伤害提高470%，同时消耗25点黑白魔元""")

const MORGEN = 15 # 释放魔法获得魔元数量
const MORGEN_MAX = 100 # 魔元上限
const VERTHUNDER_PW = 1.10 # 魔法威力
const REDOUBLEMENT_PW = 4.70 # 魔连攻威力提升

var blackMorgen = 0 # 黑魔元
var whiteMorgan = 0 # 白魔元
#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	blackMorgen = 0 # 黑魔元
	whiteMorgan = 0 # 白魔元

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder" && aiCha != null: verthunder(true)

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL && Chara.cellRan(aiCha, self) <= 1 && blackMorgen >= 25 && whiteMorgan >= 25:
		atkInfo.hurtVal *= REDOUBLEMENT_PW
		atkInfo.isCri = true
		blackMorgen -= 25
		whiteMorgan -= 25

# 赤闪雷/赤疾风
func verthunder(first):
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d,"onReach")
	hurtChara(aiCha, att.mgiAtk * VERTHUNDER_PW, Chara.HurtType.MGI)

	var n = sys.rndRan(0, 1)
	if n == 0 && blackMorgen < 100:
		blackMorgen += MORGEN
		if blackMorgen > 100: blackMorgen = 100
	if n == 1 && whiteMorgan < 100:
		whiteMorgan += MORGEN
		if whiteMorgan > 100: whiteMorgan = 100

	if first:
		yield(reTimer(1), "timeout")
		verthunder(false)