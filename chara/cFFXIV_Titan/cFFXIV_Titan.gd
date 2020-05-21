extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "泰坦之灵"
	attCoe.atkRan = 1
	attCoe.maxHp = 3.5
	attCoe.atk = 2
	attCoe.mgiAtk = 1
	attCoe.def = 2.5
	attCoe.mgiDef = 2.5
	lv = 2
	evos = ["cFFXIV_Titan_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_RockBuster", 5)#添加cd技能
	addSkillTxt("[碎岩]：冷却时间5s，为周围2格的友军附加3层[抵御]")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5_1":
		var chas = getCellChas(cell, 2)
		for i in chas:
				i.addBuff(b_diYu.new(3))