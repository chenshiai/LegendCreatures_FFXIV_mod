var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var PlayChas = []
var ChangeSwitch = false

func _init():
	print("最终幻想14：—————— 仇恨机制加载 ——————")
	pass



func createRetreat():
	sys.main.connect("onBattleStart", self, "getTankChas")
	sys.main.connect("onBattleEnd", self, "closeSelf")
	Utils.createUiButton("退避", Vector2(1140, 425), self, "changeHateTarget", {})
	sys.newBaseMsg("退避使用说明", """选择玩家双防较高的两名单位作为[坦克]
点击[退避]按钮后，会转移所有敌人的仇恨到其中一个[坦克]身上。
若两名[坦克]都阵亡，[退避]将无法生效！
注意：被转移仇恨的目标头上会出现红色感叹号[!]""")
	

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
