extends Chara

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
	addCdSkill("skill_Summon", 30)
	addSkillTxt("""[毁荡]：冷却时间4s，对目标造成[90%]法强的魔法伤害
[召唤I]：被动，随机召唤[迦楼罗/伊弗利特/泰坦]与召唤师攻击共同作战，召唤兽死亡后过一会才可召唤下一个
[溃烂爆发]：冷却时间6s，对目标造成[100%]法强的魔法伤害，根据目标当前debuff数量提高伤害，每个提高[30%]威力""")

var RUINIII_PW = 0.90 # 毁荡威力
var FESTER_PW = 1 # 溃烂爆发威力
var FESTER_N_PW = 0.30 # 层数提升威力
var summonIsLive = false # 召唤兽是否存活

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_RuinIII": ruinIII()
	if id == "skill_Fester": fester()
	if id == "skill_Summon" && !summonIsLive: summon(lv)

func _onBattleStart():
	._onBattleStart()
	summon(lv)

# 毁荡	
func ruinIII():
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d,"onReach")
	if aiCha != null:
		hurtChara(aiCha, att.mgiAtk * RUINIII_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 溃烂爆发	
func fester():
	var eff:Eff = newEff("sk_shiBao")
	eff.position = aiCha.position
	eff.scale /= 4

	var sf = 0
	for bf in aiCha.buffs :
		if bf.isNegetive :
			sf += 1
			
	yield(reTimer(0.5), "timeout")
	if aiCha != null:
		hurtChara(aiCha, att.mgiAtk * (FESTER_PW + FESTER_N_PW * sf), Chara.HurtType.MGI, Chara.AtkType.SKILL)

func summon(lv):
	var n = sys.rndRan(0, 2)
	summonIsLive = true
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

func _onCharaDel(cha):
	_onCharaDel(cha)
	if (cha.team == self.team
		&& cha.id == "cFFXIV_Evlet"
		|| cha.id == "cFFXIV_Kaluro"
		|| cha.id == "cFFXIV_Titan"):
		summonIsLive = false