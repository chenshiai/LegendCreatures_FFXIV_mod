extends "../cFFXIVHumen_2/cFFXIVHumen_2.gd"
var superbolide = true # 是否可以释放火流星

func _extInit():
	._extInit()
	chaName = tr("FFXIVHumen_2-name_2")
	lv = 3
	attAdd.spd += 0.3
	evos = []
	addSkillTxt("FFXIVHumen_2-skill_text_1")


func _onBattleStart():
	._onBattleStart()
	superbolide = true


func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if (att.hp - atkInfo.hurtVal) <= att.maxHp * 0.05:
		if self.team == 2 and sys.rndPer(60):
			superbolide = false

		if superbolide:
			atkInfo.hurtVal = 0
			BUFF_LIST.b_Superbolide.new({"cha": self, "dur": 8})
			yield(reTimer(0.1), "timeout")
			Utils.draw_effect("shieldBlue", position, Vector2(0, -20), 14, 2)
			att.hp = 1
			superbolide = false


func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == NORMAL:
		FFHurtChara(atkInfo.hitCha, att.atk * 0.35, MGI, EFF)