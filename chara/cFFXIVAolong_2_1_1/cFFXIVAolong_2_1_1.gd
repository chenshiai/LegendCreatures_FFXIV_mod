extends "../cFFXIVAolong_2_1/cFFXIVAolong_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "无双斋-传奇"
	attCoe.maxHp = 4.3
	attCoe.atk = 5
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[仗剑行侠]：{TPassive}，是恶皆斩，斩杀一名敌人后恢复[5%]的HP"))

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onKillChara(atkInfo:AtkInfo):
	._onKillChara(atkInfo)
	plusHp(att.maxHp * 0.05)