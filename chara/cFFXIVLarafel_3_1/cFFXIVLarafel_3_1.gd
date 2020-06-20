extends "../cFFXIVLarafel_3/cFFXIVLarafel_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "抗争之红"
	lv = 3
	evos = []
	addCdSkill("skill_Manafication", 20)
	addSkillTxt(TEXT.format("[赤核爆/赤神圣]：{TPassive}使用魔连攻后，立即追加释放一次[赤闪雷/赤疾风]且伤害变为[220%]"))
	addSkillTxt("[倍增]：冷却20s，使当前的黑/白魔元翻倍，且魔法攻击提高10%，持续10s")
	
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Manafication":
		manafication()

func manafication():
	var eff = newEff("numHit", Vector2(30, -60))
	eff.setText("倍增！")
	blackMorgen *= 2
	whiteMorgan *= 2
	if blackMorgen > MORGEN_MAX:
		blackMorgen = MORGEN_MAX
	if whiteMorgan > MORGEN_MAX:
		whiteMorgan = MORGEN_MAX
	BUFF_LIST.b_Manafication.new(10, self)