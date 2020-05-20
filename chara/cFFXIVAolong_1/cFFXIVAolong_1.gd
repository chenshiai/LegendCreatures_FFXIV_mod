extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "暗黑骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVAolong_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Bloodspiller", 10)
	addSkillTxt("""[深恶痛绝]：被动，战斗开始时，魔法防御提高20%，受到的伤害减少10%
[噬魂斩]：被动，第三次普通攻击造成120%的伤害，并恢复自身2%的HP
[血溅]：复唱时间10s，对目标造成物理伤害，威力：250""")

const PLUSHP = 0.02 # 回复量
const BLOODSPILLER_PW = 2.50 # 血溅倍率
var atkCount = 0 # 攻击次数

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	atkCount = 0
	addBuff(b_Abhor.new())

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Bloodspiller": bloodspiller()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkCount += 1
		if atkCount == 3:
			atkCount = 0
			atkInfo.hurtVal *= 1.2
			plusHp(att.maxHp * PLUSHP)

# 血溅
func bloodspiller():
	if aiCha != null:
		hurtChara(aiCha, att.atk * BLOODSPILLER_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)


# 深恶痛绝buff
class b_Abhor:
	extends Buff
	func _init():
		attInit()
		id = "b_Abhor"
		isNegetive = false
		att.mgiDefL = 0.20

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90
