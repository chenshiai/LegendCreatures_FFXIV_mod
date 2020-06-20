var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]

var PlayChas = []
var ChangeSwitch = false
var nowTank = null

func initRetreat():
	sys.main.connect("onBattleStart", self, "getTankChas")
	sys.main.connect("onBattleEnd", self, "closeSelf")

func showInfo():
	sys.newBaseMsg(TEXT.Retreat.title, TEXT.Retreat.content)

func changeHateTarget():
	if !ChangeSwitch:
		sys.newBaseMsg("无法退避", "战斗尚未开始。或下一场战斗开始后可以使用。")
		return

	for cha in PlayChas:
		if cha != nowTank and !cha.isDeath:
			Utils.createEffect("hateFeud", cha.position, Vector2(0, -100), 10, 1.5)
			for i in sys.main.btChas:
				if i != null and !i.isDeath and i.team == 2:
					i.aiCha = cha
					nowTank = cha
					return


func getTankChas():
	ChangeSwitch = true
	PlayChas = []

	for i in sys.main.btChas:
		if i.team == 1:
			PlayChas.append(i)

	PlayChas.sort_custom(Utils.Calculation, "sort_MaxDefAndMgiDef")
	nowTank = PlayChas[0]

func closeSelf():
	ChangeSwitch = false
