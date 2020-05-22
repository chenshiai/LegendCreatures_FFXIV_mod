extends "../cFFXIVNeko_3/cFFXIVNeko_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "红叶之诗"
	lv = 3
	evos = []
	addCdSkill("skill_ApexArrow", 8)
	addSkillTxt("[辉煌箭]：被动，普通攻击有20%的概率触发，造成[330%]的物理伤害")
	addSkillTxt("[绝峰箭]：冷却时间8s，射出穿透箭对直线上单位造成[200%]的物理伤害，并赋予5层[流血]")

const REFULGENT_PW = 3.30 # 辉煌箭威力
const APEXARROW_PW = 2 # 绝峰箭威力

func _connect():
	._connect()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL && sys.rndPer(20):
		var eff = newEff("numHit", Vector2(30, -60))
		eff.setText("辉煌箭！")
		atkInfo.atkVal *= REFULGENT_PW

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_ApexArrow": apexArrow()

func apexArrow():
	if aiCha != null:
		var eff:Eff = newEff("sk_chuanTouJian", sprcPos)
		eff._initFlyPos(position + (aiCha.position - position).normalized() * 1000, 450)
		eff.connect("onInCell", self, "effInCell")

func effInCell(cell):
	var cha = matCha(cell)
	if cha != null && cha.team != team :
		hurtChara(cha, att.atk * APEXARROW_PW)
		cha.addBuff(b_liuXue.new(5))