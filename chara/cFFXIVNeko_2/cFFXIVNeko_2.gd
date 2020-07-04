extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

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
	addCdSkill("skill_Fester", 10)
	addSkillTxt(TEXT.format("""[召唤I]：战斗开始时，随机召唤[迦楼罗之灵/伊弗利特之灵/泰坦之灵]与召唤师共同作战
[毁荡]：冷却4s，对目标造成[90%]法强的{TMgiHurt}
[溃烂爆发]：冷却10s，对目标造成[120%]法强的{TMgiHurt}，根据目标当前debuff数量提高伤害，每个提高[30%]威力"""))

const RUINIII_PW = 0.90 # 毁荡威力
const FESTER_PW = 1.2 # 溃烂爆发威力
const FESTER_N_PW = 0.30 # 层数提升威力
var SummonChara = null

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_RuinIII":
		ruinIII()
		SummonChara.skill_lv1()
	if id == "skill_Fester":
		fester()
		if lv >= 3:
			SummonChara.skill_lv2()

func _onBattleStart():
	._onBattleStart()
	summon()

func _onBattleEnd():
	._onBattleEnd()
	recovery()

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

# 召唤
func summon():
	var n = sys.rndRan(0, 2)
	var id = ""
	if n == 0 :
		id = "cFFXIV_Summon1"
	elif n == 1:
		id = "cFFXIV_Summon2"
	elif n == 2:
		id = "cFFXIV_Summon3"
	present(id)

# 显灵
func present(id):
	SummonChara = sys.main.newChara(id, self.team)
	SummonChara.Summoner = self
	self.get_node("spr").add_child(SummonChara)

# 召回
func recovery():
	self.get_node("spr").remove_child(SummonChara)
	SummonChara = null

func _upS():
	if SummonChara and (SummonChara.id == "cFFXIV_Summon1" or SummonChara.id == "cFFXIV_Summon3"):
		SummonChara.normalSpr.position = aiCha.position - position + Vector2(-40, 0)

