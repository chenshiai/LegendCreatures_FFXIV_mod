var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]

var PlayChas = []
var ChangeSwitch = false

func initRetreat():
	sys.main.connect("onBattleStart", self, "getTankChas")
	sys.main.connect("onBattleEnd", self, "closeSelf")
	print("初始化退避连结")

func showInfo():
	sys.newBaseMsg(TEXT.Retreat.title, TEXT.Retreat.content)

func changeHateTarget():
	if !ChangeSwitch:
		sys.newBaseMsg("无法退避", "战斗尚未开始。或下一场战斗开始后可以使用。")
		return

	if PlayChas[1] and !PlayChas[1].isDeath:
		var t = PlayChas[1]
		PlayChas[1] = PlayChas[0]
		PlayChas[0] = t
	
	if !PlayChas[0].isDeath:
		Utils.createEffect("hateFeud", PlayChas[0].position, Vector2(0, -100), 10)
		for i in sys.main.btChas:
			if i != null and !i.isDeath and i.team == 2:
				i.aiCha = PlayChas[0]


func getTankChas():
	print("开战选坦克")
	ChangeSwitch = true
	PlayChas = []

	for i in sys.main.btChas:
		if i.team == 1:
			PlayChas.append(i)

	PlayChas.sort_custom(Utils.Calculation, "sort_MaxDefAndMgiDef")
	PlayChas.resize(2)

func closeSelf():
	print("开启退避")
	ChangeSwitch = false
