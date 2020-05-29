extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
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
	addCdSkill("skill_Embrace", 12)
	addSkillTxt("""[鼓舞激励之策]：冷却时间10s，为生命最低的友方单位恢复[110%]法强的HP，并为其附加[鼓舞]，持续5s
[鼓舞]：Buff，抵消[初始治疗量125%]的伤害，无法与占星术士的[黑夜领域]叠加""")
	addSkillTxt("""[仙光的拥抱]：被动，小仙女协助作战。每12s，为生命最低的友方单位恢复[40%]法强的HP""")

const ADLOQUIUM_PW = 1.10 # 鼓舞激励之策威力
const EMBRACE_PW = 0.40 # 仙光的拥抱威力
var shield_pw = 1.25 # 护盾生成量

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Adloquium":
		adloquium(ADLOQUIUM_PW, true)
	if id == "skill_Embrace":
		adloquium(EMBRACE_PW)

# 鼓舞激励之策/仙光的拥抱
func adloquium(pw, hudun = false):
	var cha = Utils.Calculation.findOneByMinHp(getAllChas(2))
	if cha != null:
		cha.plusHp(att.mgiAtk * pw)
		if hudun:
			cha.addBuff(BUFF_LIST.b_Adloquium.new(5, att.mgiAtk * pw * shield_pw))
			Utils.createEffect("shield", cha.position, Vector2(0,-30), 7)