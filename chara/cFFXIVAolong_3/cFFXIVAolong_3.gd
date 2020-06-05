extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "忍者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4.1
	attCoe.mgiAtk = 1
	attCoe.def = 2.8
	attCoe.mgiDef = 3
	attAdd.dod += 0.30
	lv = 2
	evos = ["cFFXIVAolong_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Ninjutsu", 11)
	addSkillTxt("""[攻其不备]：被动，普通攻击会给目标施加2层[流血]效果
[隐遁]：被动，获得30%的闪避""")
	addSkillTxt("""[忍术]：ÇÐ11s，随机释放以下忍术
[风魔手里剑]：对魔法攻击力最高的一名敌人造成[480%]的物理伤害
[冰遁之术]：对周围2格的敌人造成[70%]的物理伤害，并附加5层[结霜]
[火遁之术]：对周围2格的敌人造成[50%]的物理伤害，并附加5层[烧灼]""")

const FUMA_PW = 4.80 # 风魔手里剑威力
const HYOTON_PW = 0.70 # 冰遁威力
const KATON_PW = 0.50 # 火遁威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func normalAtkChara(cha):
	.normalAtkChara(cha)
	if cha != null:
		cha.addBuff(b_liuXue.new(2))

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Ninjutsu" && aiCha != null:
		Utils.createEffect("whirlwind", Vector2(position.x, position.y - 1), Vector2(0,-40), 15, 1, false)
		var n = sys.rndRan(0, 2)
		if n == 0:
			fuma()
		elif n == 1:
			hyoton()
		else:
			katon()

# 风魔手里剑
func fuma():
	var chas = getAllChas(1)
	chas.sort_custom(Utils.Calculation, "sort_MaxMgiAtk")

	var d:Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(chas[0])
	yield(d, "onReach")

	if sys.isClass(chas[0], "Chara") && chas[0] != null:
		hurtChara(chas[0], att.atk * FUMA_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 冰遁之术
func hyoton():
	var chas = getCellChas(cell, 2)
	for i in chas:
		if i != null:
			hurtChara(i, att.atk * HYOTON_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			i.addBuff(b_jieShuang.new(5))

# 火遁之术			
func katon():
	var chas = getCellChas(cell, 2)
	for i in chas:
		if i != self:
			hurtChara(i, att.atk * KATON_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			i.addBuff(b_shaoZhuo.new(5))