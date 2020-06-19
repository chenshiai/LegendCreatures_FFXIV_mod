extends Chara
func _info():
	pass
func _extInit():
	._extInit()#保留继承的处理
	chaName = "伊弗利特之灵"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 1
	attCoe.def = 2.5
	attCoe.mgiDef = 2.5
	lv = 2
	evos = ["cFFXIV_Evlet_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_BurningStrike", 5)
	addSkillTxt("[燃火强袭]：冷却5s，对目标附加3层[烧灼]")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BurningStrike" and aiCha != null:
		aiCha.addBuff(b_shaoZhuo.new(3))
