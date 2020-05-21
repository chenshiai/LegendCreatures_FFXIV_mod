extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "武士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3.3
	attCoe.atk = 4.2
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	lv = 2
	evos = ["cFFXIVAolong_2_1"]
	atkEff = "atk_dao"
	addSkillTxt("""[雪/月/花]：被动，每2次攻击前，随机获得[雪/月/花]中的一个印记，且使攻击伤害增加10%。每个印记效果如下
(雪：伤害再增加10%；月：12s内攻击提升10%；花：12s内攻速提升10%)""")
	addSkillTxt("""[居合术]：每第8次攻击，消耗当前获得的全部印记，根据印记不同的数量来释放以下效果
[彼岸花]：消耗一个印记，造成[120%]的物理伤害，并附加10层[烧灼]
[天下五剑]：消耗两个印记，对目标及周围一格敌人造成[350%]的物理伤害
[纷乱雪月花]：消耗三个印记，造成高额[720%]的物理伤害，可暴击""")

const SNOW_PW = 1.20 # 雪风威力
const MOON_PW = 1.10 # 月光威力
const FLOWER_PW = 1.10 # 花车威力
const HIGANBANE_PW = 1.20 # 彼岸花威力
const FIVESWORD_PW = 3.50 # 天下五剑威力
const SETSUGEKKA_PW = 7.20 # 纷乱雪月花威力

var snow = false # 雪
var moon = false # 月
var flower = false # 花
var atkCount = 0 # 当前攻击次数
var flash = 0 # 当前闪的数量
var beforIaijutsu = "" # 上一次居合术

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	reset()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: 
		atkCount += 1
		if atkCount == 8:
			atkCount = 0
			iaijutsu()
		elif atkCount % 2 == 0:
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
		
func iaijutsu():
	if flash == 1:
		higanBana()
		beforIaijutsu = "higanBana"
	elif flash == 2:
		beforIaijutsu = "fiveSword"
		var chas = getCellChas(aiCha.cell, 1)
		for i in chas:
			if i != self:
				fiveSword(i)
	elif flash == 3:
		setsugekka()
		beforIaijutsu = "setsugekka"
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
func higanBana():
	var d:Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")

	aiCha.addBuff(b_shaoZhuo.new(10))
	hurtChara(aiCha, att.mgiAtk * HIGANBANE_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 天下五剑
func fiveSword(cha):
	var d:Eff = newEff("sk_4_1_2",sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")

	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.atk * FIVESWORD_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 纷乱雪月花
func setsugekka():
	var pw = 1
	if sys.rndPer(att.cri * 100): pw = 2
	hurtChara(aiCha, att.atk * SETSUGEKKA_PW * pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 重置所有状态
func reset():
	snow = false
	moon = false
	flower = false
	atkCount = 0
	flash = 0

# 月光buff
class b_MoonLigth:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_MoonLigth"
		isNegetive = false
		att.atkL = 0.10
		life = dur

	func _upS():
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
		att.spd = 0.10
		life = dur
		
	func _upS():
		life = clamp(life, 0, 12)
		if life <= 1: life = 0