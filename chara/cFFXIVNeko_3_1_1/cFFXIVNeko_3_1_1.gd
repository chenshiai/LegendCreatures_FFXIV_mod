extends "../cFFXIVNeko_3_1/cFFXIVNeko_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "让泰尔-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 5
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 4
	evos = []
	addSkillTxt("""[和平颂歌]：被动，战斗开始时，为自身和所有队友附加[行吟]，不可叠加
[行吟]：受到的伤害减少10%""")

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	troubadour()

func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			cha.addBuff(BUFF_LIST.b_Troubadour.new(999))