extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "拉拉肥冒险者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	atkEff = "atk_dao"
	addCdSkill("5",5)#添加cd技能
	addSkillTxt("每5秒：获得5层[狂怒]")
#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_kuangNu.new(5))