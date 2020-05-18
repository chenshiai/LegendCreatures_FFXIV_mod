extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "武士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_Setsugekka", 12)
	addSkillTxt("""[雪风/月光/花车]：被动，第二次攻击将随机释放以下效果，并获得一个印记，一个印记最多存在一个
	(雪风：增伤20%，获得“雪”；月光：增伤10%，12s内攻击提升5%，获得“月”；花车：增伤10%，12s内攻速提升10%，获得“花”)
	[居合术]：复唱时间12s，消耗当前获得的全部印记，根据不同的数量来释放以下效果
	[彼岸花]：消耗一个印记，造成物理伤害，并附加10层[烧灼]。威力：120
	[天下五剑]：消耗两个印记，对目标及周围一格敌人造成物理伤害，威力：350
	[纷乱雪月花]：消耗三个印记，造成物理伤害。威力：720)""")

var snow = false
var moon = false
var flower = false
var anum = 0
var flash = 0
#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	snow = false
	moon = false
	flower = false
	anum = 0
	flash = 0

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: 
		anum += 1
		if anum > 1 :
			anum = 0
			var bf = null
			var n = sys.rndRan(0, 2)
			if n == 0 :
				atkInfo.hurtVal *= 1.2
				if !snow :
					snow = true
					flash += 1
			elif n == 1:
				atkInfo.hurtVal *= 1.1
				if !moon :
					moon = true
					flash += 1
				addBuff(b_MoonLigth.new(12))
			else:
				atkInfo.hurtVal *= 1.1
				if !flower :
					flower = true
					flash += 1
				addBuff(b_FlowerCar.new(12))

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Setsugekka" && aiCha != null:
		if flash == 1:
			var d:Eff = newEff("sk_4_1_2",sprcPos)
			d._initFlyCha(aiCha)
			yield(d,"onReach")
			aiCha.addBuff(b_shaoZhuo.new(10))
			hurtChara(aiCha, att.mgiAtk * 1.20, Chara.HurtType.PHY)
		elif flash == 2:
			var chas = getCellChas(aiCha.cell, 1)
			yield(d,"onReach")
			for i in chas:
				if i != self:
					fx(i)
					hurtChara(i, att.atk * 3.50, HurtType.PHY)
		elif flash == 3:
			hurtChara(i, att.atk * 7.20, HurtType.PHY)

func fx(cha):
	var d:Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(cha)
	yield(d,"onReach")

class b_MoonLigth:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_MoonLigth"
		isNegetive = false
		life = dur

	func _upS():
		att.atkL = 0.05
		eff.amount = clamp(life, 1, 12)

class b_FlowerCar:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_FlowerCar"
		isNegetive = false
		life = dur
		
	func _upS():
		att.spd = 0.10
		eff.amount = clamp(life, 1, 30)
