extends "../cFFXIVAolong_2_1/cFFXIVAolong_2_1.gd"

var ShohaCount = 0

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
	addSkillTxt(TEXT.format("[照破]：{TPassive}释放[居合术]后累计一层剑压，达到三层后对目标造成[400%]的{TPhyHurt}"))
	if not is_connected("swordPpressure", self, "Shoha"):
		connect("swordPpressure", self, "Shoha")

const SHOHA_PW = 4 # 照破威力	


func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	ShohaCount = 0

func Shoha():
	ShohaCount += 1
	if ShohaCount >= 3:
		FFHurtChara(aiCha, att.atk * SHOHA_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
		ShohaCount = 0

