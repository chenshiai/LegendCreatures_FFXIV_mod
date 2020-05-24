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

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Dreadwyrm":
		dreadwyrm()
		enkindleBahamut()

func dreadwyrm():
	addBuff(BUFF_LIST.b_Dreadwyrm.new(8))

func enkindleBahamut():
	var cell = aiCha.cell
	var chas = getCellChas(cell, 2)
	Utils.createEffect("nuclearExplosion", aiCha.position, Vector2(0,-40), 15)
	yield(reTimer(0.5), "timeout")
	
	for i in chas:
		if i != null: 
			hurtChara(i, att.mgiAtk * ENKINDLEBAHAMUT_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)