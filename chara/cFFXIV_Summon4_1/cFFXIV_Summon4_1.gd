extends "../cex___FFXIVSummon/cex___FFXIVSummon.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "小仙女·lv3"
	lv = 3
	evos = []
	addSkillTxt("[仙光的低语]：冷却20s，为周围3格全体友方单位并附加[持续恢复]效果，持续5s")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

