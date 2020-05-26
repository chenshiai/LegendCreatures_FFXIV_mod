extends "../cFFXIVHumen_2_1/cFFXIVHumen_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "桑克瑞德-传奇"
	attCoe.maxHp = 6.3
	attCoe.atk = 5
	attCoe.def = 5.8
	attCoe.mgiDef = 5.8
	lv = 4
	evos = []
	addCdSkill("skill_BlastingZone", 15)
	addSkillTxt("""[爆破领域]：冷却时间15s，对目标造成[380%]的物理伤害
[超火流星]：被动，生命值低于10%时，有概率触发。生命值降为1点，15s内免疫任何伤害，最多触发一次""")

var baseId = ""
const BLASTINGZONE_PW = 4.80 # 爆破领域威力
var superbolide = true # 是否可以释放火流星

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	superbolide = true

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if att.hp <= att.maxHp * 0.10 && sys.rndPer(84) && superbolide:
		Utils.createEffect("shield", position, Vector2(0,-30), 7)
		atkInfo.hurtVal = 0
		addBuff(BUFF_LIST.b_Superbolide.new(15))
		superbolide = false
		yield(reTimer(0.5), "timeout")
		att.hp = 1
		
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BlastingZone":
		if aiCha != null:
			hurtChara(aiCha, att.atk * BLASTINGZONE_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)