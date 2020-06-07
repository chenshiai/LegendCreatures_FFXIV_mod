extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "迦楼罗之灵"
	attCoe.atkRan = 2
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 1
	attCoe.def = 2
	attCoe.mgiDef = 2
	lv = 2
	evos = ["cFFXIV_Kaluro_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_WindBlade", 5)#添加cd技能
	addSkillTxt("[烈风刃]：冷却时间5s，对目标附加3层[中毒]")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_WindBlade" and aiCha != null:
		aiCha.addBuff(b_zhonDu.new(3))
