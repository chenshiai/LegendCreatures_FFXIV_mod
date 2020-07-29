var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var CrusadeConfig = {} # 讨伐战配置
var DeathList = []
var FFControl

func _init():
		print("最终幻想14：—————— 讨伐歼灭读取 ——————")
		call_deferred("dataInit")

func dataInit():
	for id in chaData.infoDs.keys():
		if id.begins_with("cFFXIVBoss"):
			var BossPath = chaData.infoDs[id].dir
			var FFConfig = load("%s/%s/FFConfig.gd" % [BossPath, id])
			var CrusadeId = FFConfig.CrusadeInfo.id
			CrusadeConfig[CrusadeId] = FFConfig.CrusadeInfo
			CrusadeConfig[CrusadeId].checked = false
			print("最终幻想14：《%s》√ " % [FFConfig.CrusadeInfo.text])


func openDeathList():
	sys.main.connect("onCharaDel", self, "appendDeathCha")
	sys.main.connect("onBattleEnd", self, "initDeathCha")

func getDeathList():
	return DeathList

func appendDeathCha(cha: Chara):
	if cha.team == 1 and !cha.isSumm:
		DeathList.append(cha)

func initDeathCha():
	DeathList = []

func rndRanBoss():
	var CrusadeCheckList = []
	var BossChara = null

	for key in CrusadeConfig.keys():
		var item = CrusadeConfig[key]
		if item.checked:
			CrusadeCheckList.append(item)

	if CrusadeCheckList.size() > 0:
		var n = sys.rndRan(0, CrusadeCheckList.size() - 1)
		clear(null)
		BossChara = add_unit(CrusadeCheckList[n].id, CrusadeCheckList[n].position, 2)
	return BossChara


func clear(bosscha):
	var cha
	for i in range(0,9):
		for j in range(0,6):
			cha = sys.main.matCha(Vector2(i, j))
			if cha != null and cha.team != 1 and cha != bosscha:
				sys.main.delMatChara(cha)

func add_unit(id, position, team = 2):
	var cha
	cha = sys.main.newChara(id, team)
	sys.main.map.add_child(cha)
	sys.main.setMatCha(position, cha)
	cha.isDeath = true
	cha.revive(cha.att.maxHp)
	return cha
