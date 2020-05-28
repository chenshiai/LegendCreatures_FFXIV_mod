extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
var Utils = globalData.infoDs["g_FFXIVUtils"]

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "暗黑骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 5
	attCoe.atk = 3.6
	attCoe.mgiAtk = 0
	attCoe.def = 3.6
	attCoe.mgiDef = 4.4
	lv = 2
	evos = ["cFFXIVAolong_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Bloodspiller", 10)
	addSkillTxt("当前暗黑值：%d / 1000" % [darkCount])
	addSkillTxt("""[深恶痛绝]：被动，战斗开始时，魔法防御提高20%，受到的伤害减少10%
[噬魂斩]：被动，第三次普通攻击造成[120%]的伤害，并恢复自身2%的HP
[血溅]：冷却时间10s，对目标造成[250%]的物理伤害""")

const PLUSHP = 0.02 # 回复量
const BLOODSPILLER_PW = 2.50 # 血溅倍率
var atkCount = 0 # 攻击次数
var darkCount = 0 # 暗黑值

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	atkCount = 0
	addBuff(BUFF_LIST.b_Abhor.new())

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Bloodspiller":
		bloodspiller()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkCount += 1
		if atkCount == 3:
			atkCount = 0
			atkInfo.atkVal *= 1.2
			plusHp(att.maxHp * PLUSHP, true)

# 血溅
func bloodspiller():
	if aiCha != null:
		hurtChara(aiCha, att.atk * BLOODSPILLER_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)