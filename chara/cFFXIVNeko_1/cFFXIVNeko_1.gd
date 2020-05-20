extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "学者"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVNeko_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_Adloquium", 10)
	addCdSkill("skill_Embrace", 12)
	addCdSkill("skill_WhisperingDawn", 20)
	addSkillTxt("""[鼓舞激励之策]：复唱时间10s，为生命最低的友方单位恢复HP，并为其附加[鼓舞]，持续5s，威力：110
[鼓舞]：Buff，抵消治疗量初始值125%的伤害，无法与占星术士的[黑夜领域]叠加""")
	addSkillTxt("""[仙光的拥抱]：被动，小仙女协助作战。每12s，为生命最低的友方单位恢复HP，威力：40
[仙光的低语]：被动，小仙女协助作战。每20s，给所有队友施加持续恢复效果，持续5s，威力：10""")

const ADLOQUIUM_PW = 1.10 # 鼓舞激励之策威力
const EMBRACE_PW = 0.40 # 仙光的拥抱威力
const WHISPERINGDAWN_PW = 0.10 # 仙光的低语威力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Adloquium": adloquium(ADLOQUIUM_PW, true)
	if id == "skill_Embrace": adloquium(EMBRACE_PW)
	if id == "skill_WhisperingDawn": whisperingDawn()

# 鼓舞激励之策/仙光的拥抱
func adloquium(pw, hudun = false):
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null:
		cha.plusHp(att.mgiAtk * pw)
		if hudun:
			cha.addBuff(b_Adloquium.new(5, att.mgiAtk * pw * 1.25))

# 仙光的低语
func whisperingDawn():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			cha.addBuff(b_WhisperingDawn.new(5, att.mgiAtk * WHISPERINGDAWN_PW))

# 鼓舞，护盾。可以吸收一定数值的伤害
class b_Adloquium:
	extends Buff
	var total setget set_total, get_total

	func get_total():
		return total
	func set_total(val):
		total = val

	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Adloquium"
		total = val
		life = dur

	func _connect():
		._connect()
		masCha.connect("onHurt", self, "onHurt")

	func _upS():
		life = clamp(life, 0, 5)
		if life <= 1: life = 0

	func onHurt(atkInfo:AtkInfo):
		if total > 0:
			if total > atkInfo.hurtVal:
				total -= atkInfo.atkVal
				atkInfo.hurtVal = 0
			else:
				atkInfo.hurtVal -= total
				total = 0
		elif total < 0:
			total = 0

# 仙光的低语
class b_WhisperingDawn:
	extends Buff
	var hot setget set_hot, get_hot

	func get_hot():
		return hot
	func set_hot(val):
		hot = val

	func _init(dur = 1, val = 0):
		attInit()
		id = "b_WhisperingDawn"
		hot = val
		life = dur

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 5)
		if life <= 1: life = 0
						