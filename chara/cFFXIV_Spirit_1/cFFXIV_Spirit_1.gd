extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "占星术士-白"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dang"
	atkEff = "atk_dang"
	addCdSkill("skill_DrawCard", 8)#添加cd技能
	addCdSkill("skill_Mascot", 10)#添加cd技能
	addSkillTxt("""[抽卡]：复唱时间8s，随机抽取一张卡施加效果给自己或者敌人，5层效果
(太阳神之衡[烧灼]；放浪神之箭[失明]；战争神之枪[流血]；世界树之干[抵御]；河流神之瓶[结霜]；建筑神之塔[魔御])
[福星]：复唱时间10s，为生命最低的友方单位恢复HP，威力：70""")
	addCdSkill("skill_StarPhase", 18)#添加cd技能
	addSkillTxt("""[阳星相位]：复唱时间18s，回复全场友军的HP，威力：40
[白昼学派]：被动，阳星相位会给目标施加持续恢复效果，持续5秒，该效果无法叠加，威力：15""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

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

	if id == "skill_Mascot":
		var cha = null
		var m = 10000
		var chas = getAllChas(2)
		for i in chas:
			if i.att.hp / i.att.maxHp < m :
				cha = i
				m = i.att.hp / i.att.maxHp
		if cha != null:
			cha.plusHp(att.mgiAtk * 0.7)

	if id == "skill_StarPhase":
		var ailys = getAllChas(2)
		for cha in ailys:
			if cha != null:
				cha.plusHp(att.mgiAtk * 0.4)
				cha.addBuff(b_LuckyStar.new(5, att.mgiAtk * 0.15))

class b_LuckyStar:
	extends Buff
	var total setget set_total, get_total

	func get_total():
		return total
	func set_total(val):
		total = val

	func _init(dur = 1, val = 0):
		attInit()
		id = "b_LuckyStar"
		total = val
		life = dur

	func _upS():
		masCha.plusHp(total)
		life = clamp(life, 0, 5)
		if life <= 1: life = 0
			