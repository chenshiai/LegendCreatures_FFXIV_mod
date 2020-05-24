extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
var Utils = globalData.infoDs["g_FFXIVUtils"]

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "召唤师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4.2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVNeko_2_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_RuinIII", 4)
	addCdSkill("skill_Fester", 6)
	addSkillTxt("""[召唤I]：战斗开始时，随机召唤[迦楼罗之灵/伊弗利特之灵/泰坦之灵]与召唤师共同作战
[毁荡]：冷却时间4s，对目标造成[90%]法强的魔法伤害
[溃烂爆发]：冷却时间6s，对目标造成[100%]法强的魔法伤害，根据目标当前debuff数量提高伤害，每个提高[30%]威力""")

const RUINIII_PW = 0.90 # 毁荡威力
const FESTER_PW = 1 # 溃烂爆发威力
const FESTER_N_PW = 0.30 # 层数提升威力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_RuinIII":
		ruinIII()
	if id == "skill_Fester":
		fester()

func _onBattleStart():
	._onBattleStart()
	yield(reTimer(0.5), "timeout")
	summon(lv)

# 毁荡	
func ruinIII():
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")
	if aiCha != null:
		hurtChara(aiCha, att.mgiAtk * RUINIII_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 溃烂爆发	
func fester():
	var eff:Eff = newEff("sk_shiBao")
	eff.position = aiCha.position
	eff.scale /= 3
	var sf = 0
	for bf in aiCha.buffs:
		if bf.isNegetive:
			sf += 1

	if aiCha != null:
		hurtChara(aiCha, att.mgiAtk * (FESTER_PW + FESTER_N_PW * sf), Chara.HurtType.MGI, Chara.AtkType.SKILL)

func summon(lv):
	var n = sys.rndRan(0, 2)
	if lv == 2:
		if n == 0 :
			newChara("cFFXIV_Evlet", self.cell)
		elif n == 1:
			newChara("cFFXIV_Kaluro", self.cell)
		elif n == 2:
			newChara("cFFXIV_Titan", self.cell)
	elif lv == 3:
		if n == 0 :
			newChara("cFFXIV_Evlet_1", self.cell)
		elif n == 1:
			newChara("cFFXIV_Kaluro_1", self.cell)
		elif n == 2:
			newChara("cFFXIV_Titan_1", self.cell)