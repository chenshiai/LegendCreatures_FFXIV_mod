extends "../cFFXIVHumen_2/cFFXIVHumen_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "守约之刃"
	lv = 3
	attAdd.spd += 0.2
	evos = []
	addSkillTxt("""[续剑]：被动，攻击速度提高20%
[血壤]：被动，普通攻击会附加50%攻击力的魔法伤害
[超火流星]：被动，生命值低于10%时，有概率触发。生命值降为1点，15s内免疫任何伤害，最多触发一次""")

var superbolide = true # 是否可以释放火流星
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	superbolide = true

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if att.hp <= att.maxHp * 0.10 && sys.rndPer(70) && superbolide:
		Utils.createEffect("shield", position, Vector2(0,-30), 7)
		atkInfo.hurtVal = 0
		addBuff(BUFF_LIST.b_Superbolide.new(15))
		superbolide = false
		yield(reTimer(0.5), "timeout")
		att.hp = 1

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		if atkInfo.hitCha != null:
			hurtChara(atkInfo.hitCha, att.atk * 0.5, Chara.HurtType.MGI, Chara.AtkType.EFF)