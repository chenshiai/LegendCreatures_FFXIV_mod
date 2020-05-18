extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "忍者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	attAdd.dod += 0.30
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_Ninjutsu", 11)
	addSkillTxt("""[背刺]：被动，普通攻击会给目标施加3层[流血]效果
[隐遁]：被动，获得30%的闪避
[忍术]：复唱时间11s，随机释放以下忍术
[风魔手里剑]：对魔法攻击力最高的敌人造成物理伤害，威力：250
[冰遁之术]：对周围1格的敌人造成物理伤害，并附加5层[结霜]，威力：50
[火遁之术]：对周围1格的敌人造成物理伤害，并附加5层[烧灼]，威力：30""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_liuXue.new(3))

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

func fuma():
	var chas = getAllChas(1)
	chas.sort_custom(self, "sort")
	for i in range(1):
		if i >= chas.size() : break
		var cha:Chara = chas[i]
		fx(cha)

func hyoton():
	var chas = getCellChas(cell,1)
	for i in chas:
		if i != self:
			hurtChara(i, att.atk * 0.50, HurtType.PHY)
			i.addBuff(b_jieShuang.new(5))

func katon():
	var chas = getCellChas(cell,1)
	for i in chas:
		if i != self:
			hurtChara(i, att.atk * 0.20, HurtType.PHY)
			i.addBuff(b_shaoZhuo.new(5))

func sort(a,b):
	if a.att.mgiAtk > b.att.mgiAtk :
		return true
	return false

func fx(cha):
	var d:Eff = newEff("sk_4_1_2",sprcPos)
	d._initFlyCha(cha)
	yield(d,"onReach")
	if sys.isClass(cha,"Chara"):
		hurtChara(cha, att.atk * 2.50)