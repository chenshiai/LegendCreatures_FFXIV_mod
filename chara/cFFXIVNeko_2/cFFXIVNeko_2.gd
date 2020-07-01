extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var SummonChara = null

func _info():
	pass

func _extInit():
	._extInit()
	OCCUPATION = "MagicDPS"
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
	addSkillTxt(TEXT.format("""[召唤I]：战斗开始时，随机召唤[迦楼罗之灵/伊弗利特之灵/泰坦之灵]与召唤师共同作战
[毁荡]：冷却4s，对目标造成[90%]法强的{TMgiHurt}
[溃烂爆发]：冷却6s，对目标造成[100%]法强的{TMgiHurt}，根据目标当前debuff数量提高伤害，每个提高[30%]威力"""))

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
	summon(self.lv)

# 毁荡	
func ruinIII():
	var d:Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")
	FFHurtChara(aiCha, att.mgiAtk * RUINIII_PW, MGI, SKILL)

# 溃烂爆发	
func fester():
	var eff:Eff = newEff("sk_shiBao")
	eff.position = aiCha.position
	eff.scale /= 3
	var sf = 0
	for bf in aiCha.buffs:
		if bf.isNegetive:
			sf += 1
	FFHurtChara(aiCha, att.mgiAtk * (FESTER_PW + FESTER_N_PW * sf), MGI, SKILL)

func summon(lv):
	var n = sys.rndRan(0, 2)
	var summonCha = ""
	if n == 0 :
		summonCha = "cFFXIV_Summon1"
	elif n == 1:
		summonCha = "cFFXIV_Summon2"
	elif n == 2:
		summonCha = "cFFXIV_Summon3"

	if lv == 3:
		summonCha += "_1"
	elif lv == 4:
		summonCha += "_1_1"

	SummonChara = newChara(summonCha, self.cell)
	if SummonChara:
		SummonChara.Summoner = self