extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "白魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVLarafel_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_CureII", 10)#添加cd技能
	addCdSkill("skill_CureIII", 15)#添加cd技能
	addCdSkill("skill_Regen", 18)#添加cd技能
	addSkillTxt("""[救疗]：复唱时间10s，为生命最低的友方单位恢复HP，威力：80
[愈疗]：复唱时间15s，为全体友方单位恢复HP，威力：60
[再生]：复唱时间18s，为生命最低的友方单位附加持续恢复效果，持续18s，威力：15""")

const CUREII_PW = 0.80 # 救疗威力
const CUREIII_PW = 0.6 # 愈疗威力
const REGEN_PW = 0.15 # 再生威力

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_CureII": cureII()
	if id == "skill_CureIII": cureIII()
	if id == "skill_Regen": regen()

# 救疗
func cureII():
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null:
		cha.plusHp(att.mgiAtk * CUREII_PW)

# 愈疗		
func cureIII():
	var allys = getAllChas(2)
	for cha in allys:
		if cha != null:
			cha.plusHp(att.mgiAtk * CUREIII_PW)

# 再生
func regen():
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null:
		cha.addBuff(b_Regen.new(18, att.mgiAtk * REGEN_PW))

# 再生buff
class b_Regen:
	extends Buff
	var hot setget set_hot, get_hot

	func get_hot():
		return hot
	func set_hot(val):
		hot = val

	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Regen"
		hot = val
		life = dur

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 18)
		if life <= 1: life = 0