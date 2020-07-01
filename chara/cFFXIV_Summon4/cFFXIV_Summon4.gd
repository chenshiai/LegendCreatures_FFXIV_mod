extends "../cex___FFXIVSummon/cex___FFXIVSummon.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "小仙女·lv2"
	lv = 2
	evos = []
	addSkillTxt("小仙女会与学者一同作战")
	addSkillTxt("[仙光的拥抱]：冷却4s，为生命最低的友方单位恢复学者[15%]法强的生命值")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

