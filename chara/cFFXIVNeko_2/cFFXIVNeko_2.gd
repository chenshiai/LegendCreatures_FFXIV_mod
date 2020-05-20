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
	addCdSkill("skill_RuinIII", 3)
	addCdSkill("skill_Summon", 80)
	addCdSkill("skill_Fester", 5)
	addSkillTxt("""[毁荡]：复唱时间3s，对目标造成魔法伤害，威力：90
[迦楼罗/伊芙利特/泰坦]：复唱时间8s，随机召唤一个召唤师与召唤师攻击共同作战，召唤兽死亡后才可召唤下一个
[溃烂爆发]：复唱时间5s，根据目标当前debuff数量提高伤害，每个提高30威力，威力：100""")

var RUINIII_PW = 0.90 # 毁荡威力
var FESTER_PW = 1 # 溃烂爆发威力
var FESTER_N_PW = 0.30 # 层数提升威力
var summonIsLive = false

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_RuinIII" && aiCha != null: ruinIII()
	if id == "skill_Summon": summon()
	if id == "skill_Fester" && aiCha != null: fester()

func _onBattleStart():
	._onBattleStart()
	summon()


# 毁荡	
func ruinIII():
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d,"onReach")

	hurtChara(aiCha, att.mgiAtk * RUINIII_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 溃烂爆发	
func fester():
	var eff:Eff = newEff("sk_shiBao")
	eff.position = aiCha.position
	eff.scale /= 4
	yield(reTimer(0.5),"timeout")

	var sf = 0
	for bf in aiCha.buffs :
		if bf.isNegetive :
			sf += 1
	
	hurtChara(aiCha, att.mgiAtk * (FESTER_PW + FESTER_N_PW * sf), Chara.HurtType.MGI, Chara.AtkType.SKILL)

func summon():
	newChara("c6", self.cell)	