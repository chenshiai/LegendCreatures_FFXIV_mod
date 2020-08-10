extends "../cFFXIVNeko_3/cFFXIVNeko_3.gd"
const REFULGENT_PW = 3.50 # 辉煌箭威力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onBattleStart():
	._onBattleStart()
	troubadour()


func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Troubadour.new({"cha": cha})


func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL and sys.rndPer(20):
		refulgent()

var refulgentList = [
	[Vector2(10, -40), Vector2(50, 0)],
	[Vector2(10, -60), Vector2(50, -100)],
	[Vector2(-10, -40), Vector2(-50, 0)],
	[Vector2(-10, -60), Vector2(-50, -100)],
]
func refulgent():
	# Utils.draw_efftext("辉煌箭！", position, "#fff000")
	FFHurtChara(aiCha, att.atk * REFULGENT_PW, PHY, SKILL)
	var effList = []
	for item in refulgentList:
		var eff = sys.newEff("numHit", position)
		eff.normalSpr.position = item[0]
		eff.scale.x *= -2
		eff.anim.set_speed_scale(0)
		eff.setText("→", "#fff000")
		eff._initFlyPos(position + item[1], 20)
		effList.append(eff)

	yield(reTimer(0.5),"timeout")
	for item in effList:
		item._initFlyCha(aiCha, 1200)
