extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "绝枪战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_BowShock", 9)#添加cd技能
	addSkillTxt("""[王室亲卫]：被动，受到的伤害减少10%
	[弓形冲波]：复唱时间9s，对周围1格的敌人造成物理伤害，并附加4层[烧灼]。威力：160""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BowShock":
		var chas = getCellChas(cell, 1)
		for i in chas:
			if i != self:
				hurtChara(i, att.atk * 1.6, HurtType.PHY)
				i.addBuff(b_shaoZhuo.new(4))

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.90
