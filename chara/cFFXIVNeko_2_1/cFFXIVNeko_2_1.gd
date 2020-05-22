extends "../cFFXIVNeko_2/cFFXIVNeko_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "首席之唤"
	lv = 3
	evos = []
	addCdSkill("skill_Dreadwyrm", 24)
	addSkillTxt("[龙神附体]：冷却时间24s，自身魔法强度提高10%，持续8s")
	addSkillTxt("[龙神迸发]：被动，龙神附体时，对目标及周围2格内的敌人造成[700%]法强的魔法伤害")

const ENKINDLEBAHAMUT_PW = 7 # 龙神迸发威力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Dreadwyrm":
		dreadwyrm()
		enkindleBahamut()

func dreadwyrm():
	addBuff(b_Dreadwyrm.new(8))

func enkindleBahamut():
	var cell = aiCha.cell
	var chas = getCellChas(cell, 1)

	var eff:Eff = newEff("sk_shiBao")
	eff.position = aiCha.position
	eff.scale /= 2
	
	yield(reTimer(0.5), "timeout")
	print("龙神迸发!")
	for i in chas:
		if i != null: 
			hurtChara(i, att.mgiAtk * ENKINDLEBAHAMUT_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

class b_Dreadwyrm:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Dreadwyrm"
		life = dur
		isNegetive = false
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 8)
		if life <= 1: life = 0