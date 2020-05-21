extends "../cFFXIVLarafel_2/cFFXIVLarafel_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "魔石之黑"
	lv = 3
	evos = []
	addSkillTxt("[黑魔纹]：被动，当黑魔法师10s内没有移动，减少自身15%的技能冷却时间")
	addSkillTxt("[核爆]：冷却时间35s，")

func _connect():
	._connect()
