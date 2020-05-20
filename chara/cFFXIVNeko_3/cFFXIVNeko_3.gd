extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "吟游诗人"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVNeko_3_1"]
	addCdSkill("skill_LronJaws", 15)
	addCdSkill("skill_Ballad", 20)
	addCdSkill("skill_Paean", 11)
	addSkillTxt("""[伶牙俐齿]：复唱时间15s，对攻击目标造成物理伤害，并附加5层[流血][中毒]，威力：100
[贤者的叙事谣]：复唱时间20s，对目标造成物理伤害，并使队伍全员攻击伤害提高5%，持续8s，此效果无法叠加，威力：100
[光阴神的礼赞凯歌]：复唱时间11s，以HP最少的队员为目标，解除其[中毒][流血]效果，并使其免疫后来的所有负面效果，持续3s""")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_LronJaws" && aiCha != null: lronjaws()
	if id == "skill_Ballad": ballad()
	if id == "skill_Paean": paean()

# 伶牙俐齿
func lronjaws():
	normalAtkChara(aiCha)
	aiCha.addBuff(b_zhonDu.new(5))
	aiCha.addBuff(b_liuXue.new(5))

# 贤者的叙事谣
func ballad():
	normalAtkChara(aiCha)
	var chas = getAllChas(2)
	for cha in chas :
		cha.addBuff(b_Ballad.new(8))

# 光阴神的礼赞凯歌
func paean():
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null:
		cha.addBuff(b_Paean.new(3))

	var lx = cha.hasBuff("b_liuXue")
	var zd = cha.hasBuff("b_zhonDu")
	if lx != null: lx.isDel = true
	if zd != null: zd.isDel = true


# 叙事谣buff
class b_Ballad:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Ballad"
		isNegetive = false
		life = dur
	
	func _connect():
		masCha.connect("onAtkChara", self, "onAtkChara")

	func _upS():
		life = clamp(life, 0, 8)
		if life <= 1: life = 0

	func onAtkChara(atkInfo:AtkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF: 
			atkInfo.hurtVal *= 1.05

# 凯歌buff
class b_Paean:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Paean"
		isNegetive = false
		life = dur
	
	func _connect():
		masCha.connect("onAddBuff", self, "onAddBuff")

	func onAddBuff(buff:Buff):
		if buff.isNegetive :
			buff.isDel = true

	func _upS():
		life = clamp(life, 0, 3)
		if life <= 1: life = 0