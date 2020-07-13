extends "../cFFXIVLarafel_2/cFFXIVLarafel_2.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_LeyLines", 50)
	addCdSkill("skill_Xenoglossy", 30)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))

const XENOGLOSSY_PW = 7.5 # 异言威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	leyLines()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_LeyLines":
		leyLines()
	if id == "skill_Xenoglossy":
		xenoglossy()

func leyLines():
	BUFF_LIST.b_LeyLines.new({"cha": self, "dur": 30})

func xenoglossy():
	Utils.draw_effect("melanositis", aiCha.position, Vector2(0, -50), 7, 2)
	FFHurtChara(aiCha, att.mgiAtk * XENOGLOSSY_PW, MGI, SKILL)