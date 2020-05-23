extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "占星术士-昼"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 2.9
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVSpirit_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_DrawCard", 8)
	addSkillTxt("""[抽卡]：冷却时间8s，随机抽取一张卡施加效果给全部队友，持续5s。太阳神之衡[攻击力20%]；放浪神之箭[攻速20%]；
战争神之枪[暴击20%]；世界树之干[物防20%]；河流神之瓶[冷却20%]；建筑神之塔[魔防20%]""")
	addCdSkill("skill_StarPhase", 18)
	addSkillTxt("""[阳星相位]：冷却时间18s，回复全场友军[40%]法强的HP
[白昼学派]：被动，阳星相位会给目标施加持续恢复效果，每秒恢复[15%]法强的HP，持续5秒""")

const STARPHASE_PW = 0.40 # 阳星威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard" : drawCard()
	if id == "skill_StarPhase": starPhase()

func drawCard():
	var n = sys.rndRan(0, 5)
	var bf = null
	if n == 0:
		bf = BUFF_LIST.b_Balance.new(5)
	elif n == 1:
		bf = BUFF_LIST.b_Arrow.new(5)
	elif n == 2:
		bf = BUFF_LIST.b_Spear.new(5)
	elif n == 3:
		bf = BUFF_LIST.b_Bole.new(5)
	elif n == 4:
		bf = BUFF_LIST.b_Ewer.new(5)
	elif n == 5:
		bf = BUFF_LIST.b_Spire.new(5)

	var chas = getAllChas(2)
	for cha in chas:
		if cha != null && bf != null:
			cha.addBuff(bf)

# 阳星相位		
func starPhase():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			cha.plusHp(att.mgiAtk * STARPHASE_PW)
			cha.addBuff(BUFF_LIST.b_LuckyStar.new(5, att.mgiAtk * 0.15))