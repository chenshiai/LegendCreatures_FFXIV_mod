extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

const PLUSHP = 0.01 # 恢复量
const BLOODSPILLER_PW = 2.50 # 血溅倍率
var atkCount = 0 # 攻击次数
var darkCount = 0 # 暗黑值

var SKILL_TXT_1 = TEXT.format("""[深恶痛绝]：{TPassive}，战斗开始时，魔法防御提高10%，受到的伤害减少20%
[噬魂斩]：{TPassive}，第三次普通攻击造成[110%]的伤害，并恢复自身1%的HP
[血溅]：冷却10s，对目标造成[250%]的{TPhyHurt}""")

func _extInit():
	._extInit()
	chaName = "暗黑骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 5
	attCoe.atk = 3.6
	attCoe.def = 3.6
	attCoe.mgiDef = 4.4
	lv = 2
	evos = ["cFFXIVAolong_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Bloodspiller", 10)
	addSkillTxt("当前暗黑值：0 / 1000")
	addSkillTxt(SKILL_TXT_1)


func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	atkCount = 0
	BUFF_LIST.b_Abhor.new(self)

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Bloodspiller":
		bloodspiller()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkCount += 1
		if atkCount == 3:
			atkCount = 0
			atkInfo.atkVal *= 1.1
			plusHp(att.maxHp * PLUSHP, true)

# 血溅
func bloodspiller():
	if aiCha != null:
		hurtChara(aiCha, att.atk * BLOODSPILLER_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)