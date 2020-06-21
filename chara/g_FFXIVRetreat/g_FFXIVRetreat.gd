var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具

var PlayerChas = []
var ChangeSwitch = false
var nowTank = null

func initRetreat():
	sys.main.connect("onBattleStart", self, "getTankChas")
	sys.main.connect("onBattleEnd", self, "closeSelf")

func changeHateTarget():
	if !ChangeSwitch:
		sys.newBaseMsg("无法退避", "战斗尚未开始。或下一场战斗开始后可以使用。")
		return

	for cha in PlayerChas:
		if cha != nowTank and !cha.isDeath:
			Utils.createEffect("hateFeud", cha.position, Vector2(0, -50), 10, 1.5)
			for i in sys.main.btChas:
				if i != null and !i.isDeath and i.team == 2:
					i.aiCha = cha
					nowTank = cha
					return


func getTankChas():
	ChangeSwitch = true
	PlayerChas = []

	for i in sys.main.btChas:
		if i.team == 1:
			PlayerChas.append(i)

	PlayerChas.sort_custom(Utils.Calculation, "sort_MaxDefAndMgiDef")
	nowTank = PlayerChas[0]

func closeSelf():
	ChangeSwitch = false
