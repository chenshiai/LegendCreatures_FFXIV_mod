var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具

var DeathList = []

const BossList = [
  {
    "id": "cex___FFXIVOmegaF",
    "backgronud": "/img/SpaceTimeSlit.png"
  },
  {
    "id": "cex___FFXIVOmegaM",
    "backgronud": "/img/SpaceTimeSlit.png"
  },
  {
    "id": "cex___FFXIVOmega",
    "backgronud": "/img/SpaceTimeSlit1.png"
  },
  {
    "id": "cex___FFXIVInnocence",
    "backgronud": "/img/PerfectThrone.png"
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
  var n = sys.rndRan(0, 3)
  clear(null)
  Utils.backGroundChange(BossList[n].backgronud)
  var cha = addUnit(BossList[n].id, Vector2(6, 2))
  return cha

func clear(bosscha):
	var cha
	for i in range(0,8):
		for j in range(0,5):
			cha = sys.main.matCha(Vector2(i, j))
			if cha != null and cha.team != 1 and cha != bosscha:
				sys.main.delMatChara(cha)

func addUnit(id, position):
	var cha
	cha = sys.main.newChara(id, 2)
	sys.main.map.add_child(cha)
	sys.main.setMatCha(position, cha)
	cha.isDeath = true
	cha.revive(cha.att.maxHp)
	return cha