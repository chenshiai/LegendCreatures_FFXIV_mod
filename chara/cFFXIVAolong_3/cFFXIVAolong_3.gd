extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "忍者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4.1
	attCoe.mgiAtk = 2
	attCoe.def = 2.8
	attCoe.mgiDef = 3
	attAdd.dod += 0.30
	lv = 2
	evos = ["cFFXIVAolong_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Ninjutsu", 11)
	addSkillTxt("""[攻其不备]：被动，普通攻击会给目标施加2层[流血]效果
[隐遁]：被动，获得30%的闪避""")
	addSkillTxt("""[忍术]：复唱时间11s，随机释放以下忍术
[风魔手里剑]：对魔法攻击力最高的一名敌人造成物理伤害，威力：450
[冰遁之术]：对周围1格的敌人造成物理伤害，并附加5层[结霜]，威力：70
[火遁之术]：对周围1格的敌人造成物理伤害，并附加5层[烧灼]，威力：50""")

const FUMA_PW = 4.50 # 风魔手里剑威力
const HYOTON_PW = 0.70 # 冰遁威力
const KATON_PW = 0.50 # 火遁威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_liuXue.new(2))

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Ninjutsu" && aiCha != null:
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
	chas.sort_custom(self, "sort")
	for i in range(1):
		if i >= chas.size() : break
		var cha:Chara = chas[i]
		fx(cha)

# 魔法强度排序
func sort(a,b):
	if a.att.mgiAtk > b.att.mgiAtk :
		return true
	return false

# 风魔特效
func fx(cha):
	var d:Eff = newEff("sk_4_1_2",sprcPos)
	d._initFlyCha(cha)
	yield(d,"onReach")
	if sys.isClass(cha,"Chara"):
		hurtChara(cha, att.atk * FUMA_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 冰遁之术
func hyoton():
	var chas = getCellChas(cell,1)
	for i in chas:
		if i != self:
			hurtChara(i, att.atk * HYOTON_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			i.addBuff(b_jieShuang.new(5))

# 火遁之术			
func katon():
	var chas = getCellChas(cell,1)
	for i in chas:
		if i != self:
			hurtChara(i, att.atk * KATON_PW, HurtType.PHY)
			i.addBuff(b_shaoZhuo.new(5))