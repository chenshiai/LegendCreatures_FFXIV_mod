var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var BossList = []
var DeathList = []
var FFControl

func _init():
		print("最终幻想14：—————— 讨伐歼灭读取 ——————")
		call_deferred("dataInit")

func dataInit():
	for id in chaData.infoDs.keys():
		if id.begins_with("cex___FFBoss"):
			var BossPath = chaData.infoDs[id].dir
			var FFConfig = load("%s/%s/FFConfig.gd" % [BossPath, id])
			BossList.append(FFConfig.BossInfo)
			print("最终幻想14：《%s》√ " % [FFConfig.BossInfo.crusade])


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
	var n = sys.rndRan(0, BossList.size() - 1)
	clear(null)
	var cha = add_unit(BossList[n].id, BossList[n].position, 2)
	return cha


func clear(bosscha):
	var cha
	for i in range(0,8):
		for j in range(0,5):
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