extends "../cFFXIVHumen_2/cFFXIVHumen_2.gd"

var SKILL_TXT_1 = TEXT.format("""[续剑]：{TPassive}攻击速度提高50%，普通攻击会附加35%攻击力的{TMgiHurt}
[超火流星]：{TPassive}生命值低于10%时，有概率触发。生命值降为1点，10s内免疫任何伤害，最多触发一次""")

func _extInit():
	._extInit()
	chaName = "守约之刃"
	lv = 3
	attAdd.spd += 0.5
	evos = []
	addSkillTxt(SKILL_TXT_1)

var superbolide = true # 是否可以释放火流星
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	superbolide = true

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if (att.hp - atkInfo.hurtVal) <= att.maxHp * 0.10:
		if sys.rndPer(70) and superbolide:
			atkInfo.hurtVal = 0
			superbolide = false
			BUFF_LIST.b_Superbolide.new({"cha": self, "dur": 10})
			Utils.draw_effect("shieldBlue", position, Vector2(0, -20), 14, 2)
			yield(reTimer(0.5), "timeout")
			att.hp = 1

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		FFHurtChara(atkInfo.hitCha, att.atk * 0.35, MGI, EFF)