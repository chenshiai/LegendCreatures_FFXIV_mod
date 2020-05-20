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
	evos = ["cFFXIVAolong_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Setsugekka", 12)
	addSkillTxt("""[雪风/月光/花车]：被动，第二次攻击将随机释放以下效果，并获得一个印记，一个印记最多存在一个
(雪风：威力120，获得雪;月光：威力110，12s内攻击提升10%，获得月;花车：威力110，12s内攻速提升10%，获得花)""")
	addSkillTxt("""[居合术]：复唱时间12s，消耗当前获得的全部印记，根据不同的数量来释放以下效果
[彼岸花]：消耗一个印记，造成物理伤害，并附加10层[烧灼]。威力：120
[天下五剑]：消耗两个印记，对目标及周围一格敌人造成物理伤害，威力：350
[纷乱雪月花]：消耗三个印记，造成高额物理伤害。威力：720""")


const SNOW_PW = 1.20 # 雪风威力
const MOON_PW = 1.10 # 月光威力
const FLOWER_PW = 1.10 # 花车威力
const HIGANBANE_PW = 1.20 # 彼岸花威力
const FIVESWORD_PW = 3.50 # 天下五剑威力
const SETSUGEKKA_PW = 7.20 # 纷乱雪月花威力

var snow = false # 雪
var moon = false # 月
var flower = false # 花
var anum = 0 # 当前攻击次数
var flash = 0 # 当前闪的数量

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	reset()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: 
		anum += 1
		if anum > 1 :
			anum = 0
			var bf = null
			var n = sys.rndRan(0, 2)
			if n == 0 :
				atkInfo.hurtVal *= SNOW_PW
				getFlash("snow")
			elif n == 1:
				atkInfo.hurtVal *= MOON_PW
				getFlash("moon")
				addBuff(b_MoonLigth.new(12))
			else:
				atkInfo.hurtVal *= FLOWER_PW
				getFlash("flower")
				addBuff(b_FlowerCar.new(12))

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Setsugekka" && aiCha != null:
		if flash == 1:
			higanBana(aiCha)
		elif flash == 2:
			var chas = getCellChas(aiCha.cell, 1)
			for i in chas:
				if i != self:
					fiveSword(i)
		elif flash == 3:
			hurtChara(aiCha, att.atk * SETSUGEKKA_PW, Chara.HurtType.PHY)
		reset()

# 获得对应的印记
func getFlash(name):
	match name:
		"snow":
			if !snow :
				snow = true
				flash += 1
		"moon":
			if !moon :
				moon = true
				flash += 1
		"flower":
			if !flower :
				flower = true
				flash += 1

# 彼岸花
func higanBana(aiCha):
	var d:Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(aiCha)
	yield(d,"onReach")
	aiCha.addBuff(b_shaoZhuo.new(10))
	hurtChara(aiCha, att.mgiAtk * HIGANBANE_PW, Chara.HurtType.PHY)

# 天下五剑
func fiveSword(cha):
	var d:Eff = newEff("sk_4_1_2",sprcPos)
	d._initFlyCha(cha)
	yield(d,"onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.atk * FIVESWORD_PW)

# 重置所有状态
func reset():
	snow = false
	moon = false
	flower = false
	anum = 0
	flash = 0

# 月光buff
class b_MoonLigth:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_MoonLigth"
		isNegetive = false
		life = dur

	func _upS():
		att.atkL = 0.10
		life = clamp(life, 0, 12)
		if life <= 1: life = 0

# 花车buff
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
		life = clamp(life, 0, 12)
		if life <= 1: life = 0