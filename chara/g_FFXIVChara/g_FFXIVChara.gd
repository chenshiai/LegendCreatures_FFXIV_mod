var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具

var DeathList = []
var FFControl

const BossList = [
	{
		"id": "cex___FFXIVOmegaF",
		"backgronud": "/img/SpaceTimeSlit.png",
		"position": Vector2(6, 2)
	},
	{
		"id": "cex___FFXIVOmegaM",
		"backgronud": "/img/SpaceTimeSlit.png",
		"position": Vector2(6, 2)
	},
	{
		"id": "cex___FFXIVOmega",
		"backgronud": "/img/SpaceTimeSlit1.png",
		"position": Vector2(6, 2)
	},
	{
		"id": "cex___FFXIVInnocence",
		"backgronud": "/img/PerfectThrone.png",
		"position": Vector2(6, 2)
	},
	{
		"id": "cex___FFXIVDragon",
		"backgronud": "/img/CrystallizationSpace.png",
		"position": Vector2(4, 0)
	}
]

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
	var n = sys.rndRan(0, 4)
	clear(null)
	Utils.background_change(BossList[4].backgronud)
	var cha = add_unit(BossList[4].id, BossList[4].position, 2)
	FFControl = Utils.initFFControl()
	FFControl.FFMusic.play(Utils.Path + "/FFXIVClass/musicControl/DragonFantasy1.ogg.oggstr")
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