extends "../cFFXIVNeko_1/cFFXIVNeko_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "传承之学"
	lv = 3
	evos = []
	addCdSkill("skill_Succor", 15)
	addSkillTxt("[士高气昂之策]：冷却时间15s，恢复自身和周围队员[110%]法强的HP，并附加[鼓舞]效果，持续5s")
	addCdSkill("skill_SacredSoil", 20)
	addSkillTxt("[野战治疗阵]：冷却时间20s，自身和2格内周围队员受到的伤害减少10%，并附加持续恢复效果，每秒恢复[5%]法强的HP，持续10s")

const SUCCOR_PW = 1.10 # 士高气昂之策威力
const SACREDSOIL_PW = 0.05 # 野战治疗阵恢复力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Succor": succor()
	if id == "skill_SacredSoil": sacredSoil()

func succor():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			cha.plusHp(att.mgiAtk * SUCCOR_PW)
			cha.addBuff(b_Adloquium.new(5, att.mgiAtk * SUCCOR_PW * 1.25))

func sacredSoil():
	var ailys = getCellChas(cell, 2, 2)
	for cha in ailys:
		if cha != null:
			cha.addBuff(b_SacredSoil.new(10, att.mgiAtk * SACREDSOIL_PW))

class b_SacredSoil:
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
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.9

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 5)
		if life <= 1: life = 0
						