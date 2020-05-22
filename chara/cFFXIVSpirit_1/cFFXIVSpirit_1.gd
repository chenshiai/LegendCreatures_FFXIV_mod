extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "占星术士-昼"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 2.9
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVSpirit_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_DrawCard", 8)
	addSkillTxt("""[抽卡]：冷却时间8s，随机抽取一张卡施加效果给全部队友，持续5s
(太阳神之衡[狂怒]；放浪神之箭[急速]；战争神之枪[暴击20%]；世界树之干[抵御]；河流神之瓶[冷却缩减10%]；建筑神之塔[魔御])""")
	addCdSkill("skill_StarPhase", 18)
	addSkillTxt("""[阳星相位]：冷却时间18s，回复全场友军[40%]法强的HP
[白昼学派]：被动，阳星相位会给目标施加持续恢复效果，每秒恢复[15%]法强的HP，持续5秒""")

const STARPHASE_PW = 0.40 # 阳星威力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard" : drawCard()
	if id == "skill_StarPhase": starPhase()

func drawCard():
	var n = sys.rndRan(0, 5)
	var bf = null
	match n:
		0: bf = b_kuangNu.new(5)
		1: bf = b_jiSu.new(5)
		2: bf = b_baoJi.new(5)
		3: bf = b_diYu.new(5)
		4: bf = b_lengQue.new(5)
		5: bf = b_moYun.new(5)
	
	var eff = newEff("bo1")
	eff.position = position
	eff.scale *= 2

	var chas = getAllChas(2)
	for cha in chas:
		if cha != null && bf != null:
			cha.addBuff(bf)

# 阳星相位		
func starPhase():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			cha.plusHp(att.mgiAtk * STARPHASE_PW)
			cha.addBuff(b_LuckyStar.new(5, att.mgiAtk * 0.15))

class b_LuckyStar:
	extends Buff
	var hot setget set_hot, get_hot

	func get_hot():
		return hot
	func set_hot(val):
		hot = val

	func _init(dur = 1, val = 0):
		attInit()
		id = "b_LuckyStar"
		isNegetive = false
		hot = val
		life = dur

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 5)
		if life <= 1: life = 0

class b_baoJi:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_baoJi"
		isNegetive = false
		att.cri = 0.10
		life = dur

	func _upS():
		life = clamp(life, 0, 5)
		if life <= 1: life = 0

class b_lengQue:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_lengQue"
		isNegetive = false
		att.cd = 0.15
		life = dur

	func _upS():
		life = clamp(life, 0, 5)
		if life <= 1: life = 0
