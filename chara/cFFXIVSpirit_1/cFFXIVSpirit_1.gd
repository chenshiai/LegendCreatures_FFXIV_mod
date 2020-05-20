extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "占星术士-昼"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVSpirit_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_DrawCard", 8)
	addCdSkill("skill_Mascot", 10)
	addSkillTxt("""[抽卡]：复唱时间8s，随机抽取一张卡施加效果给自己或者敌人，5层效果
(太阳神之衡[烧灼]；放浪神之箭[失明]；战争神之枪[流血]；世界树之干[抵御]；河流神之瓶[结霜]；建筑神之塔[魔御])
[福星]：复唱时间10s，为生命最低的友方单位恢复HP，威力：70""")
	addCdSkill("skill_StarPhase", 18)
	addSkillTxt("""[阳星相位]：复唱时间18s，回复全场友军的HP，威力：40
[白昼学派]：被动，阳星相位会给目标施加持续恢复效果，持续5秒，无法叠加，威力：15""")

const MASCOT_PW = 0.70 # 福星威力
const STARPHASE_PW = 0.40 # 阳星威力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard" :
		var bf = null
		var n = sys.rndRan(0,5)
		if n == 0 :
			bf = b_shaoZhuo.new(5)
		elif n == 1:
			bf = b_liuXue.new(5)
		elif n == 2:
			bf = b_jieShuang.new(5)
		elif n == 3:
			bf = b_shiMing.new(5)
		elif n == 4:
			bf = b_diYu.new(5)
		elif n == 5:
			bf = b_moYu.new(5)

		if !bf.isNegetive:
			addBuff(bf)
		elif aiCha != null:
			var d:Eff = newEff("sk_feiDang", sprcPos)
			d._initFlyCha(aiCha)
			yield(d, "onReach")
			aiCha.addBuff(bf)

	if id == "skill_Mascot": mascot()
	if id == "skill_StarPhase": starPhase()

# 福星
func mascot():
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null:
		cha.plusHp(att.mgiAtk * MASCOT_PW)

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
		hot = val
		life = dur

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 5)
		if life <= 1: life = 0
			