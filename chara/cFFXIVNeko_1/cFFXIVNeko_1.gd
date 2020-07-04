extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
func _info():
	pass

func _extInit():
	._extInit()
	OCCUPATION = "MagicDPS"
	chaName = "学者"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVNeko_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_Adloquium", 10)
	addCdSkill("skill_DeathMgi", 4)
	addCdSkill("skill_Summon_2", 18)
	addCdSkill("skill_Summon_3", 20)
	addSkillTxt(TEXT.format("[死炎法]：冷却4s，对目标造成[90%]的{TMgiHurt}"))
	addSkillTxt("""[鼓舞激励之策]：冷却10s，为生命最低的友方单位恢复[60%]法强的HP，并为其附加[鼓舞]
[鼓舞]：可以抵消[治疗量125%]的伤害，持续10s，无法与占星术士的[黑夜领域]叠加""")

const ADLOQUIUM_PW = 0.60 # 鼓舞激励之策威力
const DEATHMGI_PW = 0.90 # 死炎法威力
var shield_pw = 1.25 # 护盾生成量
var SummonChara = null # 召唤兽节点

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	if !SummonChara:
		SummonChara = sys.main.newChara("cFFXIV_Summon4", self.team)
		SummonChara.Summoner = self
		self.get_node("spr").add_child(SummonChara)
		

func _onBattleEnd():
	._onBattleEnd()
	self.get_node("spr").remove_child(SummonChara)
	SummonChara = null

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Adloquium":
		adloquium()
	if id == "skill_DeathMgi":
		deathMgi()
		SummonChara.skill_lv1()
	if id == "skill_Summon_2":
		SummonChara.skill_lv2()
	if id == "skill_Summon_3":
		SummonChara.skill_lv3()

func deathMgi():
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")
	FFHurtChara(aiCha, att.mgiAtk * DEATHMGI_PW, MGI, SKILL)
		

# 鼓舞激励之策
func adloquium():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		chas[0].plusHp(att.mgiAtk * ADLOQUIUM_PW)
		BUFF_LIST.b_Adloquium.new({
			"cha": chas[0],
			"dur": 10,
			"HD": att.mgiAtk * ADLOQUIUM_PW * shield_pw
		})
		Utils.draw_effect("shield", chas[0].position, Vector2(0,-30), 7)
