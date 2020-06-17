var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]
var PlayChas = []
var ChangeSwitch = false

func _init():
	print("最终幻想14：—————— 仇恨机制加载 ——————")
	pass



func createRetreat():
	sys.main.connect("onBattleStart", self, "getTankChas")
	sys.main.connect("onBattleEnd", self, "closeSelf")
	Utils.createUiButton("退避", Vector2(1140, 425), self, "changeHateTarget", {})
	Utils.createUiButton("说明", Vector2(1140, 485), self, "showInfo", {})
	

func showInfo():
	sys.newBaseMsg(TEXT.Retreat.title, TEXT.Retreat.content)

func changeHateTarget():
	if !ChangeSwitch:
		sys.newBaseMsg("无法退避", "战斗尚未开始。或下一场战斗开始后可以使用。")
		return

	changeMainFeud()
	if !PlayChas[0].isDeath:
		Utils.createEffect("hateFeud", PlayChas[0].position, Vector2(0, -100), 10)
		for i in sys.main.btChas:
			if i != null and !i.isDeath and i.team == 2:
				i.aiCha = PlayChas[0]


func changeMainFeud():
	var t = PlayChas[1]
	if t.isDeath:
		return
	PlayChas[1] = PlayChas[0]
	PlayChas[0] = t

func getTankChas():
	ChangeSwitch = true
	PlayChas = []

	for i in sys.main.btChas:
		if i.team == 1:
			PlayChas.append(i)

	PlayChas.sort_custom(Utils.Calculation, "sort_MaxDefAndMgiDef")
	PlayChas.resize(2)

func closeSelf():
	ChangeSwitch = false
